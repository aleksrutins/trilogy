using Postgres;

namespace Tlg {
    public class Connection : Object, Json.Serializable {
        public static Gee.HashMap<string, weak Database> connections = new Gee.HashMap<string, weak Database>();
        public Database? db {
            get {
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
        public string prettyType {
            get {
                if(url == null) return "Unknown Type";
                var protocol = url.split("://")[0];

                switch(protocol) {
                    case "postgresql":
                        return "PostgreSQL";
                    default:
                        return "Unknown Type";
                }
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
            db = connect_db(url);
        }
    }
}
