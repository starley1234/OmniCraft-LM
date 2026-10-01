$fn = 32;

// ----------------------------------------------------------------------
// Revolved part: V-groove pulley R35
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 4;               // bore radius
rim_r = 35;               // rim radius
rim_t = 10;               // rim width
groove_r = 12;            // groove root radius
groove_w = 3;             // groove half width
revolve_angle = 360;      // revolve sweep, degrees

bore_d = 2 * bore_r;
rim_d = 2 * rim_r;
groove_d = 2 * groove_r;

profile = [[4, 0], [35, 0], [35, 2], [12, 5], [35, 8], [35, 10], [4, 10]];  // primary outline, 7 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
