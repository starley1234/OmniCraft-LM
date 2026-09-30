$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 11 teeth, 14 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 22;      // points of the closed outline

profile = [[32.376, 16.718], [37.51, 20.249], [31.387, 24.544], [33.797, 30.29], [26.324, 30.594], [25.245, 36.731], [18.794, 32.946], [14.568, 37.525], [11.188, 30.853], [5.158, 32.421], [5.921, 24.981], [0, 23.039], [4.665, 17.193], [0.733, 12.359], [7.818, 9.962], [7.125, 3.77], [14.38, 5.584], [17.145, 0], [22.268, 5.449], [27.612, 2.246], [28.976, 9.6], [35.204, 9.794]];  // single closed polygon, 22 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
