#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int *grid, grid_x_length, grid_y_length;
float *average_latency_map;

void bf(int, int); 
void print_grid(int*);
void print_float_grid(float*);
void reset_grid();
float average_grid();

int main(int argc, char *argv[]) {
  if (argc < 3) {
    grid_x_length = 32;
    grid_y_length = 32;
  } else {
    grid_x_length = atoi(argv[1]);
    grid_y_length = atoi(argv[2]);
  }
  
  printf("Using %dx%d grid\n", grid_x_length, grid_y_length);
  grid = (int *)malloc(sizeof(int) * grid_x_length * grid_y_length);
  average_latency_map = (float *)malloc(sizeof(float) * grid_x_length * grid_y_length);
  memset(average_latency_map, 0, sizeof(float) * grid_x_length * grid_y_length);

  for (int start_y = 0; start_y < grid_y_length; start_y++) {
    for (int start_x = 0; start_x < grid_x_length; start_x++) {
      reset_grid();
      for (int v = 0; v < grid_y_length * grid_x_length; v++) bf(start_x, start_y);
      printf("Centered on %d,%d:\n", start_x, start_y);
      //print_grid(grid);

      float avg = average_grid();
      printf("average for %d, %d: %f\n", start_x, start_y, avg); 
      average_latency_map[start_y * grid_x_length + start_x] = avg;
    }
  }

  print_float_grid(average_latency_map);
  return 0;
}

void reset_grid() {
  for (int y = 0; y < grid_y_length; y++)
    for (int x = 0; x < grid_x_length; x++) grid[y * grid_x_length + x] = -1;
}

float average_grid() {
  float sum = 0;
  for (int y = 0; y < grid_y_length; y++)
    for (int x = 0; x < grid_x_length; x++) sum += grid[y * grid_x_length + x];
  return sum / (grid_x_length * grid_y_length);
}

// populates grid with best distances
void bf(int start_x, int start_y) {
  grid[start_y * grid_x_length + start_x] = 0;
  for (int y = 0; y < grid_y_length; y++) {
    for (int x = 0; x < grid_x_length; x++) {
      if (grid[y * grid_x_length + x] > -1) {
        int current = grid[y * grid_x_length + x];
        if (x > 0) {
          int *left = grid + (y * grid_x_length + (x - 1));
          if (*left == -1 || *left > current + 1) *left = current + 1;
        }
        if (y > 0) {
          int *up = grid + ((y - 1) * grid_x_length + x);
          if (*up == -1 || *up > current + 1) *up = current + 1;
        }
        if (x < grid_x_length - 1) {
          int *right = grid + (y * grid_x_length + (x + 1));
          if (*right == -1 || *right > current + 1) *right = current + 1;
        }
        if (y < grid_y_length - 1) {
          int *down = grid + ((y + 1) * grid_x_length + x);
          if (*down == -1 || *down > current + 1) *down = current + 1;
        }
      }
    }
  }
}

void print_grid(int *target_grid) {
  for (int x = 0; x < grid_x_length; x++) {
    printf(",%d", x);
  }
  printf("\n");
  for (int y = 0; y < grid_y_length; y++) {
    printf("%d", y);
    for (int x = 0; x < grid_y_length; x++) {
      printf(",%d", target_grid[y * grid_x_length + x]);
    }
    printf("\n");
  }
}

void print_float_grid(float *target_grid) {
  for (int x = 0; x < grid_x_length; x++) {
    printf(",%d", x);
  }
  printf("\n");
  for (int y = 0; y < grid_y_length; y++) {
    printf("%d", y);
    for (int x = 0; x < grid_x_length; x++) {
      printf(",%f", target_grid[y * grid_x_length + x]);
    }
    printf("\n");
  }
}
