#ifndef LINKEDLIST_H
#define LINKEDLIST_H

#include <QObject>

class Node : public QObject {
    Q_OBJECT
    Q_PROPERTY(int data READ getData WRITE setData NOTIFY dataChanged)
public:
    Node(int data, Node* next = nullptr, QObject* parent = nullptr) : QObject(parent), m_data(data), m_next(next) {}

    int getData() const { return m_data; }
    void setData(int data) {
        if (m_data != data) {
            m_data = data;
            emit dataChanged();
        }
    }

    Node* getNext() const { return m_next; }
    void setNext(Node* next) { m_next = next; }

signals:
    void dataChanged();

private:
    int m_data;
    Node* m_next;
};

class LinkedList : public QObject {
    Q_OBJECT
    Q_PROPERTY(int score READ getScore WRITE setScore NOTIFY scoreChanged)
public:
    LinkedList(QObject* parent = nullptr) : QObject(parent), m_head(nullptr), m_score(0) {}

    Q_INVOKABLE void append(int data);
    Q_INVOKABLE int calculateTotalScore() const;
    void updateScore(int points);
    void clear();

    int getScore() const { return m_score; }
    void setScore(int score) {
        if (m_score != score) {
            m_score = score;
            emit scoreChanged();
        }
    }

signals:
    void scoreChanged();

private:
    Node* m_head;
    int m_score;
};

#endif // LINKEDLIST_H
