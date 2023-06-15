namespace Tlg.Util {
    public void bind_leaflet(Gtk.Widget target, Adw.Leaflet leaflet) {
        var expr = new Gtk.PropertyExpression(typeof(Adw.Leaflet), null, "folded");
        expr.bind(target, "show_start_title_buttons", leaflet);
    }
}