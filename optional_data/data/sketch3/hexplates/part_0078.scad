$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 6-gon R25, 4 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // number of polygon sides
plate_r = 25;             // circumscribed radius of the polygon
bore_r = 6;               // centre bore radius
bolts = 4;                // number of bolt windows
ring_r = 17.45;           // bolt-circle radius
bolt_r = 3;               // bolt window radius
plate_t = 6;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[50, 21.651], [37.5, 43.301], [12.5, 43.301], [0, 21.651], [12.5, 0], [37.5, 0]];  // primary outline, 6 points, counter clockwise
void_1 = [[30.543, 23.947], [27.296, 27.194], [22.704, 27.194], [19.457, 23.947], [19.457, 19.355], [22.704, 16.108], [27.296, 16.108], [30.543, 19.355]];  // centre bore, 8 points
void_2 = [[45.222, 22.799], [43.598, 24.423], [41.302, 24.423], [39.678, 22.799], [39.678, 20.503], [41.302, 18.879], [43.598, 18.879], [45.222, 20.503]];  // bolt window 1, 8 points
void_3 = [[27.772, 40.249], [26.148, 41.873], [23.852, 41.873], [22.228, 40.249], [22.228, 37.953], [23.852, 36.329], [26.148, 36.329], [27.772, 37.953]];  // bolt window 2, 8 points
void_4 = [[10.322, 22.799], [8.698, 24.423], [6.402, 24.423], [4.778, 22.799], [4.778, 20.503], [6.402, 18.879], [8.698, 18.879], [10.322, 20.503]];  // bolt window 3, 8 points
void_5 = [[27.772, 5.349], [26.148, 6.973], [23.852, 6.973], [22.228, 5.349], [22.228, 3.053], [23.852, 1.429], [26.148, 1.429], [27.772, 3.053]];  // bolt window 4, 8 points

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
