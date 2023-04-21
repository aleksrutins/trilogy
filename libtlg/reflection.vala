namespace Tlg {
    namespace Reflect {
        public unowned ParamSpec? find_type_property(Type t, string property) {
            var cls = (ObjectClass)t.class_ref();
            return cls.find_property(property);
        }
    }
}
