$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 6-gon R30, 6 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // number of polygon sides
plate_r = 30;             // circumscribed radius of the polygon
bore_r = 6;               // centre bore radius
bolts = 6;                // number of bolt windows
ring_r = 20.78;           // bolt-circle radius
bolt_r = 4;               // bolt window radius
plate_t = 6;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[57.956, 36.742], [36.742, 57.956], [7.765, 50.191], [0, 21.213], [21.213, 0], [50.191, 7.765]];  // primary outline, 6 points, counter clockwise
void_1 = [[34.521, 31.274], [31.274, 34.521], [26.682, 34.521], [23.435, 31.274], [23.435, 26.682], [26.682, 23.435], [31.274, 23.435], [34.521, 26.682]];  // centre bore, 8 points
void_2 = [[52.745, 35.887], [50.581, 38.052], [47.519, 38.052], [45.354, 35.887], [45.354, 32.826], [47.519, 30.661], [50.581, 30.661], [52.745, 32.826]];  // bolt window 1, 8 points
void_3 = [[38.052, 50.581], [35.887, 52.745], [32.826, 52.745], [30.661, 50.581], [30.661, 47.519], [32.826, 45.354], [35.887, 45.354], [38.052, 47.519]];  // bolt window 2, 8 points
void_4 = [[17.98, 45.202], [15.815, 47.367], [12.754, 47.367], [10.589, 45.202], [10.589, 42.141], [12.754, 39.976], [15.815, 39.976], [17.98, 42.141]];  // bolt window 3, 8 points
void_5 = [[12.602, 25.13], [10.437, 27.295], [7.375, 27.295], [5.211, 25.13], [5.211, 22.069], [7.375, 19.904], [10.437, 19.904], [12.602, 22.069]];  // bolt window 4, 8 points
void_6 = [[27.295, 10.437], [25.13, 12.602], [22.069, 12.602], [19.904, 10.437], [19.904, 7.375], [22.069, 5.211], [25.13, 5.211], [27.295, 7.375]];  // bolt window 5, 8 points
void_7 = [[47.367, 15.815], [45.202, 17.98], [42.141, 17.98], [39.976, 15.815], [39.976, 12.754], [42.141, 10.589], [45.202, 10.589], [47.367, 12.754]];  // bolt window 6, 8 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_3);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_4);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_5);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_6);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_7);
}
