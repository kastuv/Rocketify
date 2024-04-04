#include "LinkedList.h"

LinkedList::LinkedList() : head(nullptr) {}

LinkedList::~LinkedList() {
    Node* current = head;
    while (current) {
        Node* next = current->next;
        delete current;
        current = next;
    }
}

void LinkedList::append(int data) {
    if (!head) {
        head = new Node(data);
    } else {
        Node* current = head;
        while (current->next) {
            current = current->next;
        }
        current->next = new Node(data);
    }
}

int LinkedList::calculateTotalScore() const {
    int totalScore = 0;
    Node* current = head;
    while (current) {
        totalScore += current->data;
        current = current->next;
    }
    return totalScore;
}
