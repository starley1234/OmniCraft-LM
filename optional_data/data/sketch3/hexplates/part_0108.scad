$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 6-gon R40, 6 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // number of polygon sides
plate_r = 40;             // circumscribed radius of the polygon
bore_r = 6;               // centre bore radius
bolts = 6;                // number of bolt windows
ring_r = 30.94;           // bolt-circle radius
bolt_r = 2.5;             // bolt window radius
plate_t = 8;              // plate thickness, Z (extrusion height)
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[80, 34.641], [60, 69.282], [20, 69.282], [0, 34.641], [20, 0], [60, 0]];  // primary outline, 6 points, counter clockwise
void_1 = [[45.543, 36.937], [42.296, 40.184], [37.704, 40.184], [34.457, 36.937], [34.457, 32.345], [37.704, 29.098], [42.296, 29.098], [45.543, 32.345]];  // centre bore, 8 points
void_2 = [[73.25, 35.598], [71.897, 36.951], [69.983, 36.951], [68.63, 35.598], [68.63, 33.684], [69.983, 32.331], [71.897, 32.331], [73.25, 33.684]];  // bolt window 1, 8 points
void_3 = [[57.78, 62.393], [56.427, 63.746], [54.513, 63.746], [53.16, 62.393], [53.16, 60.479], [54.513, 59.126], [56.427, 59.126], [57.78, 60.479]];  // bolt window 2, 8 points
void_4 = [[26.84, 62.393], [25.487, 63.746], [23.573, 63.746], [22.22, 62.393], [22.22, 60.479], [23.573, 59.126], [25.487, 59.126], [26.84, 60.479]];  // bolt window 3, 8 points
void_5 = [[11.37, 35.598], [10.017, 36.951], [8.103, 36.951], [6.75, 35.598], [6.75, 33.684], [8.103, 32.331], [10.017, 32.331], [11.37, 33.684]];  // bolt window 4, 8 points
void_6 = [[26.84, 8.803], [25.487, 10.156], [23.573, 10.156], [22.22, 8.803], [22.22, 6.889], [23.573, 5.536], [25.487, 5.536], [26.84, 6.889]];  // bolt window 5, 8 points
void_7 = [[57.78, 8.803], [56.427, 10.156], [54.513, 10.156], [53.16, 8.803], [53.16, 6.889], [54.513, 5.536], [56.427, 5.536], [57.78, 6.889]];  // bolt window 6, 8 points

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
