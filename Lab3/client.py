import socket
import threading

def receive_messages(client_socket):
    while True:
        try:
            message = client_socket.recv(1024).decode()
            if not message:
                break
            print("Received message:", message)
        except ConnectionAbortedError:
            break


# Create a client socket and connect to the message broker
client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
client.connect(('localhost', 8888))

# Start a separate thread to receive messages from the broker
receive_thread = threading.Thread(target=receive_messages, args=(client,))
receive_thread.start()

while True:
    command = input("Enter a command: ")
    client.send(command.encode())

    if command == "QUIT":
        break

client.close()
