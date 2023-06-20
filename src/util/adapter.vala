using Trilogy.Data;

public interface Trilogy.Util.Adapter : Object {
    public abstract Connection connection {get; construct set;}

    public abstract Gtk.Widget overview_page();
}
