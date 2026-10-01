$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 6-gon R40, 3 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // number of polygon sides
plate_r = 40;             // circumscribed radius of the polygon
bore_r = 8;               // centre bore radius
bolts = 3;                // number of bolt windows
ring_r = 30.94;           // bolt-circle radius
bolt_r = 2.5;             // bolt window radius
plate_t = 8;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[80, 34.641], [60, 69.282], [20, 69.282], [0, 34.641], [20, 0], [60, 0]];  // primary outline, 6 points, counter clockwise
void_1 = [[47.391, 37.702], [43.061, 42.032], [36.939, 42.032], [32.609, 37.702], [32.609, 31.58], [36.939, 27.25], [43.061, 27.25], [47.391, 31.58]];  // centre bore, 8 points
void_2 = [[73.25, 35.598], [71.897, 36.951], [69.983, 36.951], [68.63, 35.598], [68.63, 33.684], [69.983, 32.331], [71.897, 32.331], [73.25, 33.684]];  // bolt window 1, 8 points
void_3 = [[26.84, 62.393], [25.487, 63.746], [23.573, 63.746], [22.22, 62.393], [22.22, 60.479], [23.573, 59.126], [25.487, 59.126], [26.84, 60.479]];  // bolt window 2, 8 points
void_4 = [[26.84, 8.803], [25.487, 10.156], [23.573, 10.156], [22.22, 8.803], [22.22, 6.889], [23.573, 5.536], [25.487, 5.536], [26.84, 6.889]];  // bolt window 3, 8 points

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
