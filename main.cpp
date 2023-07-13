#include "broker.capnp.h"
#include <capnp/message.h>
#include <capnp/serialize.h>
#include <capnp/serialize-packed.h>

#include <string>
#include <iostream>


namespace bp = broker::protocol;

int main(int argc, char *argv[]) {

    std::string event_name = "zeek_init";
    std::string topic_name = "/mytopic";
    ::capnp::MallocMessageBuilder builder;

    auto env = builder.initRoot<bp::Envelope>();
    env.setTopic(topic_name);
    auto data = env.initData();

    // Encode an event
    auto outer_ev = data.initList(3);
    outer_ev[0].setCount(1); // version
    outer_ev[1].setCount(1); // event type
    auto inner_ev = outer_ev[2].initList(2); // name and args
    auto name = capnp::Data::Builder((kj::byte*)event_name.c_str(), event_name.size());
    inner_ev[0].setString(name);
    inner_ev[1].initList(0);

    kj::FdOutputStream out{1};

    capnp::writeMessage(out, builder);
    // capnp::writePackedMessage(out, builder);
}
