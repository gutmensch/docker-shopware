import time, socket

from spyne import Application, ServiceBase, Unicode, rpc
from spyne.protocol.soap import Soap11
from spyne.server.wsgi import WsgiApplication


class SangrossMockService(ServiceBase):

    @rpc(Unicode, _returns=Unicode)
    def slow_request(ctx, request_id):
        time.sleep(1)
        return u'Request: %s' % request_id


hostname = socket.gethostname()

application = Application(
    services=[SangrossMockService],
    tns="http://{}:8000/".format(hostname),
    in_protocol=Soap11(validator='lxml'),
    out_protocol=Soap11())

application = WsgiApplication(application)

if __name__ == '__main__':
    import logging

    from wsgiref.simple_server import make_server

    logging.basicConfig(level=logging.DEBUG)
    logging.getLogger('spyne.protocol.xml').setLevel(logging.DEBUG)

    logging.info("listening to http://0.0.0.0:8000")
    logging.info("wsdl is at: http://{}:8000/?wsdl".format(hostname))

    server = make_server('0.0.0.0', 8000, application)
    server.serve_forever()
