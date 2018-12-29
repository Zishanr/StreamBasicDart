import 'dart:async';

class Cake {

  @override
  String toString() {
    return 'Chocolate cake';
  }
}

// Order  - Order given by customer.
class Order {
  String type;

  Order(this.type);
}

void main() {
  final StreamController controller = new StreamController();

  final Order orderObject = new Order('chocolate');

  // Named constructor StreamTransformer.fromHandlers()
  final StreamTransformer baker =
      new StreamTransformer.fromHandlers(handleData: (cakeType, sink) {
    if (cakeType == 'chocolate') {
      sink.add(new Cake());
    } else {
      sink.addError('I cant bake this cake');
    }
  });

  // Sink - Ordertaker outside the factory.
  controller.sink.add(orderObject);

  // OrderInpector receives every order object passed by OrderTaker to the factory and pass the type from order object to baker.
  controller.stream.map((order) => order.type).transform(baker).listen(
      (cake) => print('Heres your $cake'),
      onError: (error) => print('Error $error'));
}
