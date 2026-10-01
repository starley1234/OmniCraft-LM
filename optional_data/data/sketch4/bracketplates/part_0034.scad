$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: corner pad 60 x 60, fillet R15
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 3.5;             // bolt hole radius
plate_t = 8;              // plate thickness, Z (extrusion height)
leg_a = 60;               // base leg
leg_b = 60;               // height leg
fillet_r = 15;            // right-angle fillet radius
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

hole_d1 = 2 * hole_r + 2;
hole_d2 = 2 * hole_r;

profile = [[15, 0], [60, 0], [0, 60], [0, 15], [0.511, 11.118], [2.01, 7.5], [4.393, 4.393], [7.5, 2.01], [11.118, 0.511]];  // primary outline, 9 points, counter clockwise
void_1 = [[22.417, 14.059], [21.607, 15.89], [20.083, 17.189], [18.146, 17.698], [16.18, 17.316], [14.575, 16.118], [13.648, 14.343], [13.583, 12.341], [14.393, 10.51], [15.917, 9.211], [17.854, 8.702], [19.82, 9.084], [21.425, 10.282], [22.352, 12.057]];  // mount hole 1, 14 points
void_2 = [[14.236, 27.668], [13.606, 29.092], [12.42, 30.103], [10.913, 30.498], [9.384, 30.201], [8.136, 29.27], [7.415, 27.889], [7.364, 26.332], [7.994, 24.908], [9.18, 23.897], [10.687, 23.502], [12.216, 23.799], [13.464, 24.73], [14.185, 26.111]];  // mount hole 2, 14 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
}
