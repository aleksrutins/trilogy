import GObject from 'gi://GObject'

export class Connection extends GObject.Object {
    static {
        GObject.registerClass({
            Properties: {
                'name': GObject.ParamSpec.string(
                    'name',
                    'Name',
                    'The name of the connection',
                    GObject.ParamFlags.READWRITE | GObject.ParamFlags.CONSTRUCT,
                    null
                ),
                'url': GObject.ParamSpec.string(
                    'url',
                    'URL',
                    'The URL of the connection',
                    GObject.ParamFlags.READWRITE | GObject.ParamFlags.CONSTRUCT,
                    null
                )
            }
        }, this);
    }

    get name() {
        return this._name ?? null;
    }

    set name(newName) {
        if(this._name == newName) return;
        this._name = newName;
        this.notify('name');
    }

    get url() {
        return this._url ?? null;
    }

    set url(newURL) {
        if(this._url == newURL) return;
        this._url = newURL;
        this.notify('url');
    }

    get prettyType() {
        const method = this._url.split('://')[0];
        return (method == 'postgres' ? 'PostgreSQL' : 'Unknown Type');
    }
}
