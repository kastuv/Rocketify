// LinkedListWrapper.h
#ifndef LINKEDLISTWRAPPER_H
#define LINKEDLISTWRAPPER_H

#include <QObject>
#include "LinkedList.h"

class LinkedListWrapper : public QObject
{
    Q_OBJECT
    Q_PROPERTY(LinkedList* linkedList READ linkedList CONSTANT)
public:
    explicit LinkedListWrapper(QObject *parent = nullptr);
    LinkedList* linkedList() const;

private:
    LinkedList m_linkedlist;
};

#endif // LINKEDLISTWRAPPER_H
