$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 210 mm bar with 3 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [206, 0], [208.828, 1.172], [210, 4], [210, 60], [170.25, 60], [170.25, 55], [173.25, 55], [173.25, 34], [141.75, 34], [141.75, 55], [144.75, 55], [144.75, 60], [117.75, 60], [117.75, 55], [120.75, 55], [120.75, 34], [89.25, 34], [89.25, 55], [92.25, 55], [92.25, 60], [65.25, 60], [65.25, 55], [68.25, 55], [68.25, 34], [36.75, 34], [36.75, 55], [39.75, 55], [39.75, 60], [0, 60]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
