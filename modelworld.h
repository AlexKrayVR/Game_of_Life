#ifndef MODELWORLD_H
#define MODELWORLD_H


#include <QObject>
#include<QAbstractListModel>
#include"world.h"
#include<QCoreApplication>

class ModelWorld : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit ModelWorld(int size=10,  QString firstColor="white" , QString secondColor="black" );

    QHash<int,QByteArray> roleNames() const override;
    int rowCount(const QModelIndex& parent)const override;
    QVariant data(const QModelIndex& index, int role) const override;

    enum CellRoles{
        Color=Qt::UserRole+1
    };

    Q_PROPERTY(QString secondColor READ secondColorGet WRITE setSecondColor NOTIFY secondColorChanged)
    Q_PROPERTY(int size READ sizeGet WRITE setSize NOTIFY sizeChanged)

    int m_size;

    QString m_firstColor;  //empty cell
    QString m_secondColor; //filled cell

    World m_world;
    vector<QString>Cells;

    Q_INVOKABLE void changeCellByClick(int index);
    Q_INVOKABLE void nextStep();
    Q_INVOKABLE void randomStart();
    Q_INVOKABLE void clear();

    QString secondColorGet() const;

    int sizeGet() const;

public slots:
    void setSecondColor(QString secondColor);

    void setSize(int size);

signals:
    void secondColorChanged(QString secondColor);
    void sizeChanged(int size);
};


#endif // MODELWORLD_H
