@0xb1f666ef75c4bebb;

using Cxx = import "/capnp/c++.capnp";
$Cxx.namespace("broker::protocol");

struct BrokerData {

  struct Pair {
    key @0 :BrokerData;
    value @1 :BrokerData;
  }

  struct Table {
    entries @0: List(Pair);
  }

  struct Address {
    family @0 :AddressFamily;
    bytes @1 :Data;

    enum AddressFamily {
      ipv4 @0;
      ipv6 @1;
    }
  }

  struct Subnet {
    length@0 :UInt8;
    address @1 :Address;
  }

  struct Port {
    proto @0 :Protocol;
    number @1 :UInt16;

    enum Protocol {
      unknown @0;
      tcp @1;
      udp @2;
      icmp @3;
    }
  }

  union {
    none @0 :Void;
    boolean @1 :Bool;
    count @2 :UInt64;
    integer @3 :Int64;
    real @4 :Float64;
    string @5 :Data;
    address @6 :Address;
    subnet @7 :Subnet;
    port @8 :Port;
    timestamp @9 :UInt64;
    timespan @10 :UInt64;
    enumValue @11 :Text;
    set @12 :List(BrokerData);  # Unclear to me why we set is separate from list/vector currently (other than tagging)
    table @13 :Table;  # Possibly just List(Pair) ?
    list @14 :List(BrokerData);
  }
}

struct Envelope {
  topic @0 :Text;
  data @1 :BrokerData;
}
