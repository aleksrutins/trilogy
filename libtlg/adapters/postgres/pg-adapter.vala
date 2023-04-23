using Gtk;
using Gee;
using Tlg;
using Tlg.Adapters.Util.Widgets;
using Postgres;

public class Tlg.Adapters.PostgreSQL : Object, Adapter {
    public string connection_uri { get; construct set; }
    public weak Database db { get; construct set; }

    public Gtk.Widget overview_page() {
        var box = new FlowBox();
        
        var info = new HashMap<string, string>();
        info.@set("Connection URI", connection_uri);
        box.append(info_card(info));
        return box;
    }

    construct {
        db = connect_db(connection_uri);
    }
}
