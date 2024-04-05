#ifndef LINKEDLISTWRAPPER_H
#define LINKEDLISTWRAPPER_H

#include <QObject>
#include "LinkedList.h"

class LinkedListWrapper : public QObject
{
    Q_OBJECT
    Q_PROPERTY(LinkedList* linkedList READ linkedList CONSTANT)
    Q_PROPERTY(int score READ score NOTIFY scoreChanged)
public:
    explicit LinkedListWrapper(QObject *parent = nullptr);
    LinkedList* linkedList() const;
    int score() const;
    Q_INVOKABLE void increaseScore(int points);

signals:
    void scoreChanged();

private slots:
    void onScoreChanged();

private:
    LinkedList m_linkedlist;
    int m_score;
};

#endif
