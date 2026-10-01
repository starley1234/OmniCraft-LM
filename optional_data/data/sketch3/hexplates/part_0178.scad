$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 6-gon R30, 4 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // number of polygon sides
plate_r = 30;             // circumscribed radius of the polygon
bore_r = 10;              // centre bore radius
bolts = 4;                // number of bolt windows
ring_r = 20.78;           // bolt-circle radius
bolt_r = 4;               // bolt window radius
plate_t = 5;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[57.956, 36.742], [36.742, 57.956], [7.765, 50.191], [0, 21.213], [21.213, 0], [50.191, 7.765]];  // primary outline, 6 points, counter clockwise
void_1 = [[38.217, 32.805], [32.805, 38.217], [25.151, 38.217], [19.739, 32.805], [19.739, 25.151], [25.151, 19.739], [32.805, 19.739], [38.217, 25.151]];  // centre bore, 8 points
void_2 = [[52.745, 35.887], [50.581, 38.052], [47.519, 38.052], [45.354, 35.887], [45.354, 32.826], [47.519, 30.661], [50.581, 30.661], [52.745, 32.826]];  // bolt window 1, 8 points
void_3 = [[27.295, 50.581], [25.13, 52.745], [22.069, 52.745], [19.904, 50.581], [19.904, 47.519], [22.069, 45.354], [25.13, 45.354], [27.295, 47.519]];  // bolt window 2, 8 points
void_4 = [[12.602, 25.13], [10.437, 27.295], [7.375, 27.295], [5.211, 25.13], [5.211, 22.069], [7.375, 19.904], [10.437, 19.904], [12.602, 22.069]];  // bolt window 3, 8 points
void_5 = [[38.052, 10.437], [35.887, 12.602], [32.826, 12.602], [30.661, 10.437], [30.661, 7.375], [32.826, 5.211], [35.887, 5.211], [38.052, 7.375]];  // bolt window 4, 8 points

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
}
