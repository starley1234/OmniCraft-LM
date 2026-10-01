$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 6-gon R30, 4 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // number of polygon sides
plate_r = 30;             // circumscribed radius of the polygon
bore_r = 6;               // centre bore radius
bolts = 4;                // number of bolt windows
ring_r = 21.78;           // bolt-circle radius
bolt_r = 3;               // bolt window radius
plate_t = 10;             // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[60, 25.981], [45, 51.962], [15, 51.962], [0, 25.981], [15, 0], [45, 0]];  // primary outline, 6 points, counter clockwise
void_1 = [[35.543, 28.277], [32.296, 31.524], [27.704, 31.524], [24.457, 28.277], [24.457, 23.685], [27.704, 20.438], [32.296, 20.438], [35.543, 23.685]];  // centre bore, 8 points
void_2 = [[54.552, 27.129], [52.928, 28.753], [50.632, 28.753], [49.008, 27.129], [49.008, 24.833], [50.632, 23.209], [52.928, 23.209], [54.552, 24.833]];  // bolt window 1, 8 points
void_3 = [[32.772, 48.909], [31.148, 50.533], [28.852, 50.533], [27.228, 48.909], [27.228, 46.613], [28.852, 44.989], [31.148, 44.989], [32.772, 46.613]];  // bolt window 2, 8 points
void_4 = [[10.992, 27.129], [9.368, 28.753], [7.072, 28.753], [5.448, 27.129], [5.448, 24.833], [7.072, 23.209], [9.368, 23.209], [10.992, 24.833]];  // bolt window 3, 8 points
void_5 = [[32.772, 5.349], [31.148, 6.973], [28.852, 6.973], [27.228, 5.349], [27.228, 3.053], [28.852, 1.429], [31.148, 1.429], [32.772, 3.053]];  // bolt window 4, 8 points

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
