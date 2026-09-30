$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 180 mm bar with 3 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [176, 0], [178.828, 1.172], [180, 4], [180, 60], [143.5, 60], [143.5, 55], [148.5, 55], [148.5, 34], [121.5, 34], [121.5, 55], [126.5, 55], [126.5, 60], [98.5, 60], [98.5, 55], [103.5, 55], [103.5, 34], [76.5, 34], [76.5, 55], [81.5, 55], [81.5, 60], [53.5, 60], [53.5, 55], [58.5, 55], [58.5, 34], [31.5, 34], [31.5, 55], [36.5, 55], [36.5, 60], [0, 60]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
