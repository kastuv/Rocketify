// LinkedListWrapper.cpp
#include "LinkedListWrapper.h"

LinkedListWrapper::LinkedListWrapper(QObject *parent) : QObject(parent) {}

LinkedList* LinkedListWrapper::linkedList() const {
    return const_cast<LinkedList*>(&m_linkedlist);
}
