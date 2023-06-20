public enum Trilogy.Util.Protocol {
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
                return typeof(Trilogy.Adapters.PostgreSQL);
            default:
                return null;
        }
    }
    public static Protocol for_string(string? protocol) {
        switch(protocol) {
            case "postgresql":
                return POSTGRES;
            default:
                return UNKNOWN;
        }
    }
    public static Protocol for_uri(string uri) {
        var uri_protocol = uri.split("://")[0];
        return for_string(uri_protocol);
    }
}
