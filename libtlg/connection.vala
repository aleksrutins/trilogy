using Tlg;

namespace Tlg {
    public class Connection : Object, Json.Serializable {
        public static Gee.HashMap<string, Adapter> connections = new Gee.HashMap<string, Adapter>();
        public Adapter? db {
            owned get {
                return connections.@get(name);
            }
            set {
                if(value != null) connections.@set(name, value);
                else connections.unset(name);
            }
        }
        public bool connected {
            get {
                return connections.has_key(name);
            }
        }
        public string name {get; construct set;}
        public string url {get; construct set;}
        public Protocol protocol {
            get {
                if(url == null) return UNKNOWN;
                var uri_protocol = url.split("://")[0];
                return Protocol.for_string(uri_protocol);
            }
        }
        public string protocol_name {
            owned get {
                return protocol.to_string();
            }
        }

        public Connection(string name, string url) {
            Object(db: null, name: name, url: url);
        }

        construct {
            notify.connect((pspec) => {
                if(pspec.get_name() == "db") notify_property("connected");
            });
        }

        public unowned ParamSpec? find_property(string prop) {
            if(prop == "name" || prop == "url") return Tlg.Reflect.find_type_property(typeof(Connection), prop);
            else return null;
        }

        public void ensure() {
            assert(protocol != UNKNOWN);
            var type = protocol.get_adapter();
            assert(type != null);
            if(type == null) db = null;
            assert(url != null);
            db = (Adapter?)Object.@new(type,
                            connection: this);
        }
    }
}
