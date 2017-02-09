module CouchRest
  module Model
    module Connection
      extend ActiveSupport::Concern

      def server
        self.class.server
      end

      module ClassMethods

        # Overwrite the normal use_database method so that a database
        # name can be provided instead of a full connection.
        # The actual database will be validated when it is requested for use.
        # Note that this should not be used with proxied models!
        def use_database(db)
          @_use_database = db
        end

        # Overwrite the default database method so that it always
        # provides something from the configuration.
        # It will try to inherit the database from an ancester
        # unless the use_database method has been used, in which
        # case a new connection will be started.
        def database
          @database ||= begin
            if defined?(@_use_database) && @_use_database.present?
              # Avoid defining @database variable when calling super if we're going to use other database
              # this avoid threading issues
              prepare_database
            else
              prepare_database(super)
            end
          end
        end

        def server
          @server ||= CouchRest::Server.new(prepare_server_uri, :persistent => connection_configuration[:persistent])
        end

        def prepare_database(db = nil, override_use_database = false)
          db = @_use_database unless override_use_database || @_use_database.nil?
          if db.nil? || db.is_a?(String) || db.is_a?(Symbol)
            self.server.database! compute_database_name(db)
          else
            db
          end
        end

        protected

        def compute_database_name(db = nil)
          conf = connection_configuration
          [conf[:prefix], db.to_s, conf[:suffix]].reject{|s| s.to_s.empty?}.join(conf[:join])
        end

        def prepare_server_uri
          conf = connection_configuration
          userinfo = [conf[:username], conf[:password]].compact.join(':')
          userinfo += '@' unless userinfo.empty?
          "#{conf[:protocol]}://#{userinfo}#{conf[:host]}:#{conf[:port]}"
        end

        def connection_configuration
          @connection_configuration ||=
            self.connection.update(
              (load_connection_config_file[environment.to_sym] || {}).symbolize_keys
            )
        end

        def load_connection_config_file
          file = connection_config_file
          connection_config_cache[file] ||=
            (File.exists?(file) ?
              YAML::load(ERB.new(IO.read(file)).result) :
              { }).symbolize_keys
        end

        def connection_config_cache
          Thread.current[:connection_config_cache] ||= {}
        end

      end

    end
  end
end
