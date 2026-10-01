$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 6-gon R40, 3 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // number of polygon sides
plate_r = 40;             // circumscribed radius of the polygon
bore_r = 8;               // centre bore radius
bolts = 3;                // number of bolt windows
ring_r = 29.44;           // bolt-circle radius
bolt_r = 4;               // bolt window radius
plate_t = 5;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[80, 34.641], [60, 69.282], [20, 69.282], [0, 34.641], [20, 0], [60, 0]];  // primary outline, 6 points, counter clockwise
void_1 = [[47.391, 37.702], [43.061, 42.032], [36.939, 42.032], [32.609, 37.702], [32.609, 31.58], [36.939, 27.25], [43.061, 27.25], [47.391, 31.58]];  // centre bore, 8 points
void_2 = [[73.136, 36.172], [70.971, 38.337], [67.909, 38.337], [65.744, 36.172], [65.744, 33.11], [67.909, 30.945], [70.971, 30.945], [73.136, 33.11]];  // bolt window 1, 8 points
void_3 = [[28.976, 61.668], [26.811, 63.832], [23.749, 63.832], [21.584, 61.668], [21.584, 58.606], [23.749, 56.441], [26.811, 56.441], [28.976, 58.606]];  // bolt window 2, 8 points
void_4 = [[28.976, 10.676], [26.811, 12.841], [23.749, 12.841], [21.584, 10.676], [21.584, 7.614], [23.749, 5.45], [26.811, 5.45], [28.976, 7.614]];  // bolt window 3, 8 points

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
}
