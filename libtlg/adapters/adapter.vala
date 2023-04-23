public enum Tlg.Protocol {
    POSTGRES,
    UNKNOWN;

    public string to_string() {
        switch(this) {
            case POSTGRES:
                return "PostgreSQL";
            default:
                return "Unknown";
        }
    }
    public Type? get_adapter() {
        switch(this) {
            case POSTGRES:
                return typeof(Tlg.Adapters.PostgreSQL);
            default:
                return null;
        }
    }
    public static Tlg.Protocol for_string(string? protocol) {
        switch(protocol) {
            case "postgresql":
                return POSTGRES;
            default:
                return UNKNOWN;
        }
    }
    public static Tlg.Protocol for_uri(string uri) {
        var uri_protocol = uri.split("://")[0];
        return for_string(uri_protocol);
    }
}

public interface Tlg.Adapter : Object {
    public abstract Connection connection { get; construct set; }

    public abstract Gtk.Widget overview_page();
}
