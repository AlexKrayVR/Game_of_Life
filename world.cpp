#include "world.h"


World::World(int width, int height):m_width(width), m_height(height)
{
    m_world.resize(m_width,vector<int>(height));
    m_worldPrevious.resize(m_width, vector<int>(height));
}

World::~World()
{
}

void World::randomGenerationWorld()
{
    random_device random;
    mt19937 mersenne(random());
    for (int i = 0; i < m_width; i++)
    {
        for (int j = 0; j < m_height; j++)
        {
            if (mersenne() % 2 == 0)
            {
                m_world[i][j] = 1;
            }
            else
            {
                m_world[i][j] = 0;
            }
        }
    }
}

void World::copyWorld(vector<vector<int>> &world, vector<vector<int>> &worldPrevious)
{
    for (int i = 0; i < m_width; i++) {
        for (int j = 0; j < m_height; j++) {
            worldPrevious[i][j] = world[i][j];
        }
    }
}

int World::countLiveCells(vector<vector<int>>& world)
{
    int count = 0;
    for (int i = 0; i < m_width; i++)
    {
        for (int j = 0; j < m_height; j++)
        {
            if (world[i][j] == 1)
            {
                count++;
            }
        }
    }
    return count;
}

int World::countLiveNeighbors(vector<vector<int>>& world, int x, int y)
{
    int count = 0;
    int mooreNeighbors[8][2];
    int mooreNeighborsX = 0, mooreNeighborsY = 0;

    neighborhoodMoore(mooreNeighbors, x, y);

    for (int i = 0; i < 8; i++)
    {
        mooreNeighborsX = mooreNeighbors[i][0];
        mooreNeighborsY = mooreNeighbors[i][1];

        if (mooreNeighborsX < 0 || mooreNeighborsY < 0)
        {
            continue;
        }
        if (mooreNeighborsX >= m_width || mooreNeighborsY >= m_height)
        {
            continue;
        }
        if (world[mooreNeighborsX][mooreNeighborsY] == 1)
        {
            count++;
        }
    }
    return count;
}



void World::neighborhoodMoore(int mooreNeighbors[][2], int x, int y)
{
    int coordinate = 0;
    for (int i = x - 1; i <= x + 1; i++)
    {
        for (int j = y - 1; j <= y + 1; j++)
        {
            if (i == x && j == y)
            {
                continue;
            }
            mooreNeighbors[coordinate][0] = i;
            mooreNeighbors[coordinate][1] = j;
            coordinate++;
        }
    }
}

void World::nextGeneration(vector<vector<int>>& world, vector<vector<int>>& worldPrevious)
{
    int countLiveNeighborsCell = 0;
    int currentCell=0;
    for (int i = 0; i < m_width; i++)
    {
        for (int j = 0; j < m_height; j++)
        {
            currentCell = worldPrevious[i][j];
            countLiveNeighborsCell = countLiveNeighbors(worldPrevious, i, j);
            if (currentCell == 0) {
                if (countLiveNeighborsCell == 3)
                {
                    world[i][j] = 1;
                }
            }
            else
            {
                if (countLiveNeighborsCell < 2 || countLiveNeighborsCell>3) {
                    world[i][j] = 0;
                }
            }
        }
    }
}

void World::worldAfterStep()
{
    copyWorld(m_world, m_worldPrevious);
    nextGeneration(m_world, m_worldPrevious);
}

