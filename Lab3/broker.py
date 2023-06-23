import socket
import threading
import logging

class MessageBroker:
    def __init__(self, host, port):
        self.host = host
        self.port = port
        self.server = None
        self.clients = []
        self.subscriptions = {}

    def run(self):
        self.server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.server.bind((self.host, self.port))
        self.server.listen(5)

        logging.info(f"Message broker started. Listening on {self.host}:{self.port}")

        while True:
            client_socket, client_address = self.server.accept()
            logging.info(f"Client connected: {client_address[0]}:{client_address[1]}")

            client_thread = threading.Thread(target=self.handle_client, args=(client_socket,))
            client_thread.start()

    def handle_client(self, client_socket):
        self.clients.append(client_socket)

        while True:
            command = client_socket.recv(1024).decode().strip()
            if command.startswith("SUBSCRIBE"):
                self.subscribe(client_socket, command)
            elif command.startswith("PUBLISH"):
                self.publish(client_socket, command)
            elif command == "QUIT":
                self.clients.remove(client_socket)
                client_socket.close()
                break
            else:
                client_socket.send("Invalid command. Please try again.".encode())

    def subscribe(self, client_socket, command):
        _, topic = command.split(" ")
        if client_socket in self.subscriptions:
            self.subscriptions[client_socket].add(topic)
        else:
            self.subscriptions[client_socket] = {topic}

        logging.info(f"Client subscribed to topic: {topic}")

    def publish(self, client_socket, command):
        _, topic, message = command.split(" ", 2)
        for subscriber_socket, topics in self.subscriptions.items():
            if topic in topics:
                subscriber_socket.send(message.encode())

                logging.info(f"Published message '{message}' to client subscribed to topic '{topic}'")

broker = MessageBroker('localhost', 8888)
broker.run()
