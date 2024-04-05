// LinkedListWrapper.cpp
#include "linkedListwrapper.h"

LinkedListWrapper::LinkedListWrapper(QObject *parent) : QObject(parent), m_score(0) {
    connect(&m_linkedlist, &LinkedList::scoreChanged, this, &LinkedListWrapper::onScoreChanged);
}

LinkedList* LinkedListWrapper::linkedList() const {
    return const_cast<LinkedList*>(&m_linkedlist);
}

int LinkedListWrapper::score() const {
    return m_score;
}

void LinkedListWrapper::increaseScore(int points) {
    m_linkedlist.updateScore(points);
}

void LinkedListWrapper::onScoreChanged() {
    m_score = m_linkedlist.getScore();
    emit scoreChanged();
}
