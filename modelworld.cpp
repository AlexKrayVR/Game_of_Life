#include "modelworld.h"

ModelWorld::ModelWorld(int size,  QString firstColor, QString secondColor):
    m_size(size),
    m_firstColor(firstColor), m_secondColor(secondColor),
    m_world(m_size, m_size), Cells(m_size*m_size,m_firstColor)
{

}

QHash<int, QByteArray> ModelWorld::roleNames() const
{
    QHash<int, QByteArray> roles = QAbstractListModel::roleNames();
    roles[Color] = "color";
    return roles;
}

int ModelWorld::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid()) {
        return 0;
    }
    return static_cast<int>(Cells.size());
}

QVariant ModelWorld::data(const QModelIndex &index, int role) const
{
    if (!index.isValid()) {
        return QVariant();
    }
    switch (role) {
    case Color:
        return Cells[index.row()];
    default:
        return QVariant();
    }
}

void ModelWorld::changeCellByClick(int index)
{
    beginResetModel();
    if(Cells[index]==m_firstColor){
        Cells[index]=m_secondColor ;
    }else{
        Cells[index]=m_firstColor;
    }
    endResetModel();
}

void ModelWorld::nextStep()
{
    int indexCells1=0;
    for (int i = 0; i < m_size; i++)
    {
        for (int j = 0; j < m_size; j++)
        {
            if(Cells[indexCells1]==m_firstColor)
                m_world.m_world[i][j]=0;
            else{
                m_world.m_world[i][j]=1;
            }
            indexCells1++;
        }
    }

    m_world.worldAfterStep();

    int indexCells2=0;
    beginResetModel();
    for (int i = 0; i < m_size; i++)
    {
        for (int j = 0; j < m_size; j++)
        {
            if(m_world.m_world[i][j]==0)
            {Cells[indexCells2]=m_firstColor;}
            else{
                Cells[indexCells2]=m_secondColor;
            }
            indexCells2++;
        }
    }
    endResetModel();

}

void ModelWorld::randomStart()
{
    m_world.randomGenerationWorld();
    beginResetModel();
    int indexCells1=0;
    for (int i = 0; i < m_size; i++)
    {
        for (int j = 0; j < m_size; j++)
        {
            if(m_world.m_world[i][j]==0)
            {Cells[indexCells1]=m_firstColor;}
            else{
                Cells[indexCells1]=m_secondColor;
            }
            indexCells1++;
        }
    }
    endResetModel();
}

void ModelWorld::clear()
{
    beginResetModel();
    int size=Cells.size();
    for (int i = 0; i < size; i++)
    {
        Cells[i]=m_firstColor;
    }
    endResetModel();
}

QString ModelWorld::secondColorGet() const
{
    return m_secondColor;
}

int ModelWorld::sizeGet() const
{
    return m_size;
}

void ModelWorld::setSecondColor(QString secondColor)
{
    if (m_secondColor == secondColor)
        return;

    beginResetModel();
    for(int i=0;i<Cells.size();i++){
        if(Cells[i]==m_secondColor){
            Cells[i]=secondColor;
        }
    }
    endResetModel();
    m_secondColor = secondColor;
    emit secondColorChanged(m_secondColor);
}

void ModelWorld::setSize(int size)
{
    if (m_size == size)
        return;

    m_size = size;

    beginResetModel();

    m_world=World (size,size);

    Cells.resize(m_size*m_size);

    int temp=Cells.size();
    for (int i = 0; i < temp; i++)
    {
        Cells[i]=m_firstColor;
    }

    endResetModel();

    emit sizeChanged(m_size);
}
