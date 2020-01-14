#ifndef WORLD_H
#define WORLD_H
#include<random>
#include<vector>

using namespace std;

class World
{
public:

    World(int width, int height);
    ~World();

    void randomGenerationWorld();

    void copyWorld(vector<vector<int>> &world, vector<vector<int>> &worldPrevious);

    int countLiveCells(vector<vector<int>> &world);

    int countLiveNeighbors(vector<vector<int>> &world, int x, int y);

    void neighborhoodMoore(int mooreNeighbors[][2], int x, int y);

    void nextGeneration(vector<vector<int>> &world, vector<vector<int>> &worldPrevious);

    void worldAfterStep();

    vector<vector<int>> m_world;
    vector<vector<int>> m_worldPrevious;

    int m_width;
    int m_height;
};

#endif // WORLD_H
