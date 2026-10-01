$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: slot plate 70 x 50
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 4;               // bolt hole radius
plate_t = 6;              // plate thickness, Z (extrusion height)
plate_l = 70;             // plate length
plate_w = 50;             // plate width
slot_l = 28;              // slot straight length
slot_r = 5;               // slot end radius
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

slot_len = slot_l + 2 * slot_r;
slot_w = 2 * slot_r;
hole_d2 = 2 * hole_r;

profile = [[4, 0], [66, 0], [70, 4], [70, 46], [66, 50], [4, 50], [0, 46], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[49, 20], [50.913, 20.381], [52.536, 21.464], [53.619, 23.087], [54, 25], [53.619, 26.913], [52.536, 28.536], [50.913, 29.619], [49, 30], [21, 30], [19.087, 29.619], [17.464, 28.536], [16.381, 26.913], [16, 25], [16.381, 23.087], [17.464, 21.464], [19.087, 20.381], [21, 20]];  // grip slot, 18 points
void_2 = [[13.527, 41.163], [12.619, 43.024], [10.902, 44.182], [8.837, 44.327], [6.976, 43.419], [5.818, 41.702], [5.673, 39.637], [6.581, 37.776], [8.298, 36.618], [10.363, 36.473], [12.224, 37.381], [13.382, 39.098]];  // corner hole, 12 points
void_3 = [[13.527, 10.363], [12.619, 12.224], [10.902, 13.382], [8.837, 13.527], [6.976, 12.619], [5.818, 10.902], [5.673, 8.837], [6.581, 6.976], [8.298, 5.818], [10.363, 5.673], [12.224, 6.581], [13.382, 8.298]];  // corner hole, 12 points
void_4 = [[64.327, 41.163], [63.419, 43.024], [61.702, 44.182], [59.637, 44.327], [57.776, 43.419], [56.618, 41.702], [56.473, 39.637], [57.381, 37.776], [59.098, 36.618], [61.163, 36.473], [63.024, 37.381], [64.182, 39.098]];  // corner hole, 12 points
void_5 = [[64.327, 10.363], [63.419, 12.224], [61.702, 13.382], [59.637, 13.527], [57.776, 12.619], [56.618, 10.902], [56.473, 8.837], [57.381, 6.976], [59.098, 5.818], [61.163, 5.673], [63.024, 6.581], [64.182, 8.298]];  // corner hole, 12 points

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
