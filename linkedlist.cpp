#include "linkedList.h"

void LinkedList::append(int data) {
    if (!m_head) {
        m_head = new Node(data);
    } else {
        Node* current = m_head;
        while (current->getNext()) {
            current = current->getNext();
        }
        current->setNext(new Node(data));
    }
}

int LinkedList::calculateTotalScore() const {
    int totalScore = 0;
    Node* current = m_head;
    while (current) {
        totalScore += current->getData();
        current = current->getNext();
    }
    return totalScore;
}

void LinkedList::updateScore(int points) {

    m_score += points;
    emit scoreChanged();
}

void LinkedList::clear()
{
    while (m_head) {
        Node* next = m_head->getNext();
        delete m_head;
        m_head = next;
    }
    m_score = 0;
    emit scoreChanged();
}
