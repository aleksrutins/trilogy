using Gtk;
using Gee;
using Tlg;
using Tlg.Adapters.Util.Widgets;
using Postgres;

public class Tlg.Adapters.PostgreSQL : Object, Adapter {
    public Connection connection { get; construct set; }
    private Database db;

    delegate void ResultForeach(int ituple, int ifield, string value);
    static void foreach_result(Postgres.Result res, ResultForeach func) {
        var ntuples = res.get_n_tuples();
        var nfields = res.get_n_fields();
        for(int i = 0; i < ntuples; i++) {
            for(int j = 0; j < nfields; j++) {
                func(i, j, res.get_value(i, j));
            }
        }
    }

    public Gtk.Widget overview_page() {
        var box = new FlowBox();
        box.append(info_card("Properties",
                                    Host: db.get_host(),
                                    Port: db.get_port(),
                                    Database: db.get_db()));

        var tables_box = new Box(VERTICAL, 2);

        var tables = db.exec_prepared("get_tables", 0, null, null, null, 0);

        //  var status = tables.get_status();
        GLib.print(db.get_error_message());
        foreach_result(tables, (i, j, v) => {
            if(j == 0) {
                tables_box.append(new Label(v));
            }
        });
        
        box.append(titled_section("Tables", VERTICAL, tables_box));
        return box;
    }

    construct {
        db = connect_db(connection.url);
        db.prepare("get_tables", "SELECT table_name FROM information_schema.tables WHERE table_schema = 'public'", null);
    }

    ~PostgreSQL() {
        db.flush();
        Postgres.free_mem(db);
    }
}
