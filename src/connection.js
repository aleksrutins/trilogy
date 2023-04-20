import GObject from 'gi://GObject'

export class Connection extends GObject.Object {
    static {
        GObject.registerClass({
            Properties: {
                'name': GObject.ParamSpec.string(
                    'name',
                    'Name',
                    'The name of the connection'
                    GObject.ParamFlags.READWRITE,
                    null
                ),
                'url': GObject.ParamSpec.string(
                    'url',
                    'URL',
                    'The URL of the connection',
                    GObject.ParamFlags.READWRITE,
                    null
                )
            }
        }, this);
    }

    get prettyType() {
        const method = this._url.split('://')[0];
        return (method == 'postgres' ? 'PostgreSQL' : 'Unknown Type');
    }
}
