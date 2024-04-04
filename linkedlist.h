#ifndef LINKEDLIST_H
#define LINKEDLIST_H

class Node {
public:
    int data;
    Node* next;

    Node(int data) : data(data), next(nullptr) {}
};

class LinkedList {
private:
    Node* head;
public:
    LinkedList();
    ~LinkedList();
    void append(int data);
    int calculateTotalScore() const;
};

#endif // LINKEDLIST_H
