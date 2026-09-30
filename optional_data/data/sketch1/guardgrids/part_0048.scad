$fn = 32;

// ----------------------------------------------------------------------
// Guard grille: 5 slats over a 90 x 70 mm plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 28;      // points of the closed outline

profile = [[0, 0], [90, 0], [90, 70], [84, 70], [84, 10], [81, 10], [81, 60], [75, 60], [75, 10], [64.5, 10], [64.5, 60], [58.5, 60], [58.5, 10], [48, 10], [48, 60], [42, 60], [42, 10], [31.5, 10], [31.5, 60], [25.5, 60], [25.5, 10], [15, 10], [15, 60], [9, 60], [9, 10], [6, 10], [6, 70], [0, 70]];  // single closed polygon, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
