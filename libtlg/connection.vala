using Postgres;

namespace Tlg {
    public class Connection : Object, Json.Serializable {
        public unowned Database? db {get; construct set;}
        public bool connected {
            get {
                return db != null;
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

        public unowned ParamSpec? find_property(string prop) {
            if(prop == "name" || prop == "url") return Tlg.Reflect.find_type_property(typeof(Connection), prop);
            else return null;
        }

        public void ensure() {
            db = connect_db(url);
        }
    }
}
