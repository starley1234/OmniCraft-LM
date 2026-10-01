$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R30, 6 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 30;             // circumscribed radius of the polygon
bore_r = 6;               // centre bore radius
bolts = 6;                // number of bolt windows
ring_r = 16.86;           // bolt-circle radius
bolt_r = 4;               // bolt window radius
plate_t = 5;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[60, 30], [51.213, 51.213], [30, 60], [8.787, 51.213], [0, 30], [8.787, 8.787], [30, 0], [51.213, 8.787]];  // primary outline, 8 points, counter clockwise
void_1 = [[35.543, 32.296], [32.296, 35.543], [27.704, 35.543], [24.457, 32.296], [24.457, 27.704], [27.704, 24.457], [32.296, 24.457], [35.543, 27.704]];  // centre bore, 8 points
void_2 = [[50.556, 31.531], [48.391, 33.696], [45.329, 33.696], [43.164, 31.531], [43.164, 28.469], [45.329, 26.304], [48.391, 26.304], [50.556, 28.469]];  // bolt window 1, 8 points
void_3 = [[42.126, 46.132], [39.961, 48.297], [36.899, 48.297], [34.734, 46.132], [34.734, 43.07], [36.899, 40.906], [39.961, 40.906], [42.126, 43.07]];  // bolt window 2, 8 points
void_4 = [[25.266, 46.132], [23.101, 48.297], [20.039, 48.297], [17.874, 46.132], [17.874, 43.07], [20.039, 40.906], [23.101, 40.906], [25.266, 43.07]];  // bolt window 3, 8 points
void_5 = [[16.836, 31.531], [14.671, 33.696], [11.609, 33.696], [9.444, 31.531], [9.444, 28.469], [11.609, 26.304], [14.671, 26.304], [16.836, 28.469]];  // bolt window 4, 8 points
void_6 = [[25.266, 16.93], [23.101, 19.094], [20.039, 19.094], [17.874, 16.93], [17.874, 13.868], [20.039, 11.703], [23.101, 11.703], [25.266, 13.868]];  // bolt window 5, 8 points
void_7 = [[42.126, 16.93], [39.961, 19.094], [36.899, 19.094], [34.734, 16.93], [34.734, 13.868], [36.899, 11.703], [39.961, 11.703], [42.126, 13.868]];  // bolt window 6, 8 points

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
