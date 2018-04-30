header header_h {
    bit<8> field;
}

struct struct_t {
    header_h hdr;
}

control ctrl(inout struct_t input, out bit<8> out1, out header_h out2) {
    bit<8> tmp0;
    bit<8> tmp1;
    header_h tmp2;
    header_h tmp3;
    @name("ctrl.act") action act_0() {
        tmp0 = input.hdr.field;
        input.hdr.setValid();
        tmp1 = tmp0;
        tmp2 = input.hdr;
        input.hdr.setInvalid();
        tmp3 = tmp2;
    }
    @hidden action act() {
        out1 = tmp1;
        out2 = tmp3;
    }
    @hidden table tbl_act {
        actions = {
            act_0();
        }
        const default_action = act_0();
    }
    @hidden table tbl_act_0 {
        actions = {
            act();
        }
        const default_action = act();
    }
    apply {
        tbl_act.apply();
        tbl_act_0.apply();
    }
}

control MyControl<S, H>(inout S i, out bit<8> o1, out H o2);
package MyPackage<S, H>(MyControl<S, H> c);
MyPackage<struct_t, header_h>(ctrl()) main;

