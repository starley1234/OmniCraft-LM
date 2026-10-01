$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 6-gon R40, 4 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // number of polygon sides
plate_r = 40;             // circumscribed radius of the polygon
bore_r = 6;               // centre bore radius
bolts = 4;                // number of bolt windows
ring_r = 30.94;           // bolt-circle radius
bolt_r = 2.5;             // bolt window radius
plate_t = 10;             // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[80, 34.641], [60, 69.282], [20, 69.282], [0, 34.641], [20, 0], [60, 0]];  // primary outline, 6 points, counter clockwise
void_1 = [[45.543, 36.937], [42.296, 40.184], [37.704, 40.184], [34.457, 36.937], [34.457, 32.345], [37.704, 29.098], [42.296, 29.098], [45.543, 32.345]];  // centre bore, 8 points
void_2 = [[73.25, 35.598], [71.897, 36.951], [69.983, 36.951], [68.63, 35.598], [68.63, 33.684], [69.983, 32.331], [71.897, 32.331], [73.25, 33.684]];  // bolt window 1, 8 points
void_3 = [[42.31, 66.538], [40.957, 67.891], [39.043, 67.891], [37.69, 66.538], [37.69, 64.624], [39.043, 63.271], [40.957, 63.271], [42.31, 64.624]];  // bolt window 2, 8 points
void_4 = [[11.37, 35.598], [10.017, 36.951], [8.103, 36.951], [6.75, 35.598], [6.75, 33.684], [8.103, 32.331], [10.017, 32.331], [11.37, 33.684]];  // bolt window 3, 8 points
void_5 = [[42.31, 4.658], [40.957, 6.011], [39.043, 6.011], [37.69, 4.658], [37.69, 2.744], [39.043, 1.391], [40.957, 1.391], [42.31, 2.744]];  // bolt window 4, 8 points

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
