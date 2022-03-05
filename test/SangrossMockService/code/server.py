import time, socket

from spyne import Application, ServiceBase, Unicode, rpc
from spyne.protocol.soap import Soap11
from spyne.server.wsgi import WsgiApplication
from urllib.parse import urljoin
from os import getenv

class SangrossMockService(ServiceBase):

    @rpc(Unicode, _returns=Unicode)
    def GetCustomers(ctx, request_id):
        time.sleep(1)
        return u'Request: %s' % request_id

    @rpc(Unicode, _returns=Unicode)
    def GetStocks(ctx, request_id):
        time.sleep(1)
        return u'Request: %s' % request_id

    @rpc(Unicode, _returns=Unicode)
    def GetOP(ctx, request_id):
        time.sleep(1)
        return u'Request: %s' % request_id

    @rpc(Unicode, _returns=Unicode)
    def GetPrices(ctx, request_id):
        time.sleep(1)
        return u'Request: %s' % request_id

    @rpc(Unicode, _returns=Unicode)
    def GetTopProducts(ctx, request_id):
        time.sleep(1)
        return u'Request: %s' % request_id

    @rpc(Unicode, _returns=Unicode)
    def GetDeliveryNotes(ctx, request_id):
        time.sleep(1)
        return u'Request: %s' % request_id


hostname = socket.gethostname()

application = Application(
    services=[SangrossMockService],
    tns='tns',
    in_protocol=Soap11(validator='lxml'),
    out_protocol=Soap11())

application = WsgiApplication(application)

if __name__ == '__main__':
    import logging

    from wsgiref.simple_server import make_server

    logging.basicConfig(level=logging.DEBUG)
    logging.getLogger('spyne.protocol.xml').setLevel(logging.DEBUG)

    with make_server('', int(getenv('SERVER_PORT')), application) as httpd:
        logging.info("wsdl is at: http://{}:{}{}?wsdl".format(hostname,
            getenv('SERVER_PORT'), urljoin('/', getenv('SCRIPT_NAME'))))
        httpd.serve_forever()
