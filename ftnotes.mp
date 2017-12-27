%kindle_mode := 1;
u := if known kindle_mode: 0.707cm else: 1cm fi;

input graph

pickup pencircle scaled .4pt; % not bp;
defaultpen := savepen;

pen thickpen;
thickpen := pencircle scaled .8pt;

labeloffset := 3pt; % not bp

vardef theaxes(expr llc, urc)(expr xlabel, ylabel) =
	save z; pair z[];
	z1 = (xpart llc, 0);
	z2 = (xpart urc, 0);
	z3 = (0, ypart llc);
	z4 = (0, ypart urc);
	image (
		drawarrow z1 -- z2;
		drawarrow z3 -- z4;
		label.rt(xlabel, z2);
		label.rt(ylabel, z4);
	)
enddef;

def drawaxes(expr llc, urc)(expr xlabel, ylabel) =
	draw theaxes(llc, urc)(xlabel, ylabel)
enddef;

def thearc(expr alpha, beta) =
	(dir alpha {dir (alpha+90)} ..
	dir beta {dir (beta+90)})
enddef;

def xylabels =
	("x" infont "cmmi10", "y" infont "cmmi10")
enddef;

pi := 3.14159;
rad := 180/pi;

path sinewave;
sinewave := for i = -180 step 30 until 180:
	if i<>-180: .. fi (i/180, sind i) endfor;

beginfig(1);
	save theta;
	theta = 60;
	drawaxes((-2u, -2u), (2u, 2u)) xylabels;
	draw fullcircle scaled 2u withpen thickpen;
	z1 = (dir theta) scaled u;
	draw z1 withpen pencircle scaled dotlabeldiam;
	draw origin -- z1;
	draw z1 -- (x1, 0) dashed evenly;
	draw thearc(0, theta) scaled .2u;
	label.urt(btex$\scriptstyle\theta$etex, dir .2theta scaled .1u);
	drawarrow thearc(theta, 80) scaled 1.1u;
	label.top(btex$\scriptstyle\omega$etex, dir theta scaled 1.1u);
	save offset; pair offset;
	offset := (3.5u, 0);
	draw image(
		drawaxes((-.5u, -2u), (4.5u, 2u))
			(btex$\omega t$etex, btex$\sin\omega t$etex);
		draw (for i=1,3: if i>1: & fi
			(sinewave shifted (i, 0) yscaled -1)
		endfor) scaled u withpen thickpen;
	) shifted offset;
	z2 = (theta/180, sind theta) scaled u shifted offset;
	draw z2 withpen pencircle scaled dotlabeldiam;
	draw (0, y1) -- z2 dashed evenly;
	draw z2 -- (x2, 0) dashed evenly;
	label.bot(btex$\theta$etex, (x2, 0));
endfig;

beginfig(2);
	save n; n := 5;
	drawaxes((-2u, -2u), (2u, 2u)) xylabels;
	draw fullcircle scaled 2u withpen thickpen;
	for i = 0 upto n-1:
		z[i] = dir (360/n*i) scaled u;
		draw z[i] withpen pencircle scaled dotlabeldiam;
		draw origin--z[i] dashed evenly;
		label(decimal(i), z[i] scaled (1+6pt/u));
	endfor
endfig;

beginfig(3);
	drawaxes((-4u, -1.5u), (4u, 1.5u))
		("t" infont "cmmi10", "I" infont "cmmi10");
	for i = -2 step 2 until 2:
		draw image (
			draw ((-u, -u)--(0, -u)) withpen thickpen;
			draw ((0, u)--(u, u)) withpen thickpen;
			draw (0, -u)--(0, u) dashed evenly;
			draw (-u, -u)--(-u, 0) dashed evenly;
			draw (u, u)--(u, 0) dashed evenly;
		) shifted (i*u, 0);
	endfor
	label.lft(btex$I_m$etex, (0, u));
	label.lrt("T" infont "cmmi10", (2u, 0));
	label.llft(btex$-{T\over2}$etex, (-u, 0));
	label.lrt(btex$T\over2$etex, (u, 0));
endfig;

vardef groupfig(expr n) = 
	save m; m := (3n-1)/2;
	drawaxes((-3.5u, -1.5u), (3.5u, 1.5u))
		("t" infont "cmmi10", "I" infont "cmmi10");
	draw (for i = -m upto m: if i<>-m: & fi
		sinewave shifted (2i, 0)
	endfor) xscaled (u/n) yscaled (4u/(n*pi)) withpen thickpen;
enddef;

beginfig(4); groupfig(1); endfig;
beginfig(5); groupfig(3); endfig;
beginfig(6); groupfig(5); endfig;

vardef groupfig(expr n) = 
	save m, p; m := (3n-1)/2;
	path p;
	for i = -180*n step 15 until 180*n:
		if i=-180*n: p := else: .. fi
		(i/180/n, sind (i/n) for j = 3 step 2 until n:
			+ sind ((i/n)*j)/j endfor)
	endfor;
	drawaxes((-3.5u, -1.5u), (3.5u, 1.5u))
		("t" infont "cmmi10", "I" infont "cmmi10");
	draw (for i = -1 upto 1: if i <> -1: & fi
		p shifted (2i, 0)
	endfor) xscaled u yscaled (4u/pi) withpen thickpen;
enddef;


beginfig(7); groupfig(3); endfig;
beginfig(8); groupfig(5); endfig;
beginfig(9); groupfig(19); endfig;

beginfig(10);
	save T; transform T;
	%T := identity rotated 90 slanted .57735 rotated -90;
	(0,1) transformed T = (0,1);
	(1,0) transformed T = (1,0) rotated -30;
	(2,0) transformed T = (2,0) rotated -30;
	save Y, Z; pair Y, Z;
	save m;
	Y := (dir -30) * u;
	Z := (dir 30) * u;
	drawarrow -Z -- 3.5Z;
	drawarrow -4Y -- 4Y;
	drawarrow (0,-1.5u) -- (0,3u);
	label.rt("n" infont "cmmi10", 3.5Z);
	label.rt("t" infont "cmmi10", 4Y);
	label.rt("I" infont "cmmi10", (0,3u));
	for n = 1 step 2 until 5:
		m := (3n-1)/2;
		draw (for i = -m upto m: if i<>-m: & fi
			sinewave shifted (2i, 0)
		endfor) xscaled (u/n) yscaled (4u/(n*pi))
			transformed T shifted (Z*n/2) withpen thickpen;
	endfor
endfig;

beginfig(11);
	drawaxes((-.5u, 0),(6u, 2u))
		("n" infont "cmmi10", "I" infont "cmmi10");
	save H; H := 4u/pi;
	for i = 1 step 2 until 5:
		draw (i*u, 0) -- (i*u, H/i);
		draw (i*u, H/i) withpen pencircle scaled dotlabeldiam;
	endfor;
	for i = 0 step 2 until 4:
		draw (i*u, 0) withpen pencircle scaled dotlabeldiam;
	endfor
endfig;

beginfig(12);
	drawaxes((-3u, -1u), (3u, 3u))
		(btex$\omega$etex, btex$X(j\omega)$etex);
	draw (-2.5u, 0) -- (-u, 0) withpen thickpen;
	draw (-u, 0)--(-u, 2u) dashed evenly;
	draw (-u, 2u) -- (u, 2u) withpen thickpen;
	draw (u, 0)--(u, 2u) dashed evenly;
	draw (u, 0) -- (2.5u, 0) withpen thickpen;
	label.bot(btex$\omega_c$etex, (u, 0));
	label.urt("1", (0, 2u));
endfig;

beginfig(13);
	drawaxes((-3u, -1u), (3u, 1.5u))
		("t" infont "cmmi10", btex$x(t)$etex);
	save p; path p;
	p := (0, 1) for t = 1 upto 25:
		.. (.1t, sind(t*18)/(pi*0.1t))
	endfor;
	draw (reverse(p xscaled -1) & p) scaled u withpen thickpen;
endfig;

beginfig(14);
	drawaxes((-3u, -1u), (3u, 1.5u))
		("t" infont "cmmi10", btex$\delta(t)$etex);
	drawarrow origin -- (0, 1u) withpen thickpen;
	draw (-2u,0)--(2u,0) withpen thickpen;
	draw origin withpen pencircle scaled 2pt;
	draw origin withpen pencircle scaled 1pt withcolor white;
endfig;

beginfig(15);
	drawaxes((-3u, -1u), (3u, 1.5u))
		(btex$\omega$etex, btex$X(j\omega)$etex);
	draw (-.5u, 0) -- (0, u) -- (.5u, 0) withpen thickpen;
	label.bot(btex$\omega_m$etex, (.5u, 0));
endfig;

beginfig(16);
	drawaxes((-3u, -1u), (3u, 1.5u))
		(btex$\omega$etex, btex$X_c(j\omega)$etex);
	for i = -1 step 2 until 1:
		drawarrow (origin -- (0, u)) shifted (i*1.5u, 0);
	endfor
	label.bot(btex$-\omega_r$etex, (-1.5u, 0));
	label.bot(btex$\omega_r$etex, (1.5u, 0));
endfig;

beginfig(17);
	drawaxes((-3u, -1u), (3u, 1.5u))
		(btex$\omega$etex, btex$Y(j\omega)$etex);
	for i = -1 step 2 until 1:
		draw image(
			draw (-.5u, 0) -- (0, .5u) -- (.5u, 0) withpen thickpen;
			draw origin -- (0, .5u) dashed evenly;
			label.bot(if i = -1: btex$-\omega_r$etex
				else: btex$\omega_r$etex fi, origin);
		) shifted (i * 1.5u, 0);
	endfor
endfig;

path sincsquarewave;
sincsquarewave := (0, 1) for t = 1 upto 25:
	.. (.1t, (sind(18t)/(pi*.1t))**2)
endfor;
sincsquarewave := (reverse(sincsquarewave xscaled -1)&sincsquarewave);

beginfig(18);
	drawaxes((-3u, -1u), (3u, 1.5u))
		("t" infont "cmmi10", btex$x(t)$etex);
	draw sincsquarewave scaled u withpen thickpen;
endfig;

path cosinewave;
cosinewave := ((subpath (3,12) of sinewave) shifted (-.5, 0)) &
		((subpath (0,3) of sinewave) shifted (1.5, 0));

beginfig(19);
	drawaxes((-3u, -1u), (3u, 1.5u))
		("t" infont "cmmi10", btex$x_c(t)$etex);
	draw (for i := -9 upto 9: if i <> -9: & fi
		cosinewave shifted (2i, 0)
	endfor) xscaled (u/8) yscaled u withpen thickpen;
endfig;

beginfig(20);
	drawaxes((-3u, -1u), (3u, 1.5u))
		("t" infont "cmmi10", btex$y(t)$etex);
	save p, q, r; pair q, r; path p;
	save t;
	for i := 0 upto 9:
		for j := if i=0: 7 else: 0 fi step .25 until length cosinewave:
			q := point j of cosinewave;
			t := (xpart q + 2i);
			r := (t, (sind (180/8*t) / (pi/8*t))**2 * ypart q);
			p := if known p: p -- fi r;
		endfor
	endfor
	p := reverse(p xscaled -1)...(0,1)...p;
	draw p xscaled (u/8) yscaled u withpen thickpen;
	draw sincsquarewave scaled u dashed evenly;
endfig;

beginfig(21);
	drawaxes((0, -1u), (6u, 1.5u))
		(btex$\omega$etex, btex$Y(j\omega)$etex);
	z1 = (u, 0);
	z2 = (2u, 1u);
	z3 = (3u, 0);
	z4 - z1 = z5 - z2 = z6 - z3 = (1.5u, 0);
	z7 = whatever[z2,z3]; x7 = x4;
	z8 = whatever[z4,z5]; x8 = x3;
	draw z1--z2--z7--z8--z5--z6 withpen thickpen;
	draw z7--z3 dashed evenly;
	draw z4--z8 dashed evenly;
	draw (x2, 0) -- z2 dashed evenly;
	label.bot(btex$\omega_{r1}$etex, (x2, 0));
	draw (x5, 0) -- z5 dashed evenly;
	label.bot(btex$\omega_{r2}$etex, (x5, 0));
endfig;

vardef battery@#(expr p) =
	interim linecap := squared;
	draw image(
		draw (-.1u, .025u)--(.1u, .025u);
		draw (-.05u, -.025u)--(.05u, -.025u) withpen thickpen;
	) shifted p;
	pair @#.a, @#.k;
	@#.a := (0, .025u) shifted p;
	@#.k := (0, -.025u) shifted p;
enddef;

vardef resistor@#(expr p) =
	save h, pitch;
	h := .1u; pitch := .2u;
	draw ((-2.5, 0)
	for i = -2 upto 2:
		-- (i-.25, -1) -- (i+.25, 1)
	endfor -- (2.5, 0)) xscaled pitch yscaled h shifted p;
	pair @#.a, @#.b, @#.c;
	@#.a := (-2.5*pitch, 0) shifted p;
	@#.b := (2.5*pitch, 0) shifted p;
	@#.c := p;
enddef;

vardef capacitor@#(expr p) =
	pair @#.a, @#.b, @#.c;
	@#.a := p shifted (0, .05u);
	@#.b := p shifted (0, -.05u);
	@#.c := p;
	draw @#.a shifted (-.1u, 0) -- @#.a shifted (.1u, 0);
	draw @#.b shifted (-.1u, 0) -- @#.b shifted (.1u, 0);
enddef;

vardef ground(expr p) =
	%interim linecap := squared;
	for i = 1 upto 3:
		draw ((-.1u/i, -.05u*(i-1))--(.1u/i, -.05u*(i-1))) shifted p;
	endfor
enddef;

beginfig(22);
	resistor.Ra(origin);
	resistor.Rb((2u, 0));
	z1 = Ra.a shifted (-u, 0);
	z2 = Rb.b shifted (u, 0);
	z3 = z1 shifted (0, -2u);
	z4 = z2 shifted (0, -2u);
	z5 = .5[z1,z3];
	z6 = .5[z2,z4];
	z7 = .5[z3,z4];
	z8 = z7 shifted (0, -.2u);
	z9 = .5[Ra.b,Rb.a];
	battery.Va(z5);
	battery.Vb(z6);
	ground(z8);
	draw Va.a -- z1 -- Ra.a;
	draw Ra.b -- Rb.a;
	draw Rb.b -- z2 -- Vb.a;
	draw Va.k -- z3 -- z4 -- Vb.k;
	draw z7--z8;
	drawdblarrow z7--z9;
	label.lft(btex$V_1$etex, z5 shifted (-.1u, 0));
	label.rt(btex$V_2$etex, z6 shifted (.1u, 0));
	label.top(btex$R_1$etex, Ra.c shifted (0, .1u));
	label.top(btex$R_2$etex, Rb.c shifted (0, .1u));
	picture pic;
	pic := thelabel(btex$V_o$etex, .5[z7,z9]);
	unfill bbox.pic;
	draw pic;
endfig;

beginfig(23);
	resistor.Ra(origin);
	resistor.Rb((2u, 0));
	z1 = Ra.a shifted (-u, 0);
	z2 = Rb.b shifted (u, 0);
	z3 = z1 shifted (0, -2u);
	z4 = z2 shifted (0, -2u);
	z5 = .5[z1,z3];
	z6 = .5[z2,z4];
	z7 = .5[z3,z4];
	z8 = z7 shifted (0, -.2u);
	z9 = .5[Ra.b,Rb.a];
	battery.Va(z5);
	ground(z8);
	draw Va.a -- z1 -- Ra.a;
	draw Ra.b -- Rb.a;
	draw Va.k -- z3 -- z4 -- z2 -- Rb.b;
	draw z7--z8;
	drawdblarrow z7--z9;
	label.lft(btex$V_1$etex, z5 shifted (-.1u, 0));
	label.rt(btex\phantom{$V_2$}etex, z6 shifted (.1u, 0));
	label.top(btex$R_1$etex, Ra.c shifted (0, .1u));
	label.top(btex$R_2$etex, Rb.c shifted (0, .1u));
	picture pic;
	pic := thelabel(btex$V_o^{(1)}$etex, .5[z7,z9]);
	unfill bbox.pic;
	draw pic;
endfig;

beginfig(24);
	drawaxes((-3u, -1u), (3u, 2.5u))
		("t" infont "cmmi10", btex$\tilde x(t)$etex);
	save p, q, r; pair q, r; path p;
	save t;
	for i := 0 upto 9:
		for j := if i=0: 7 else: 0 fi step .25 until length cosinewave:
			q := point j of cosinewave;
			t := (xpart q + 2i);
			r := (t, 2 * ((sind (180/8*t) / (pi/8*t))**2) * (ypart q ** 2));
			p := if known p: p -- fi r;
		endfor
	endfor
	p := reverse(p xscaled -1)...(0,2)...p;
	draw p xscaled (u/8) yscaled u withpen thickpen;
	draw sincsquarewave scaled u dashed evenly;
endfig;

beginfig(25);
	drawaxes((-4u, -1u), (4u, 1.5u))
		(btex$\omega$etex, btex$\widetilde X(j\omega)$etex);
	for i = -2 step 2 until 2:
		draw image(
			draw (-.5u, 0) -- (0, if i <> 0: .5 fi u)
				-- (.5u, 0) withpen thickpen;
			draw origin -- (0, if i <> 0: .5 fi u)
				dashed evenly;
			if i <> 0:
			label.bot(TEX("$"&decimal(i)&"\omega_r$"), origin);
			fi
		) shifted (i * 1.5u, 0);
	endfor
endfig;

beginfig(26);
	drawaxes((-4u, -1u), (4u, 1.5u))
		(btex$\omega$etex, btex$\widetilde X(j\omega)H(j\omega)$etex);
	for i = -2 step 2 until 2:
		draw image(
			draw (-.5u, 0) -- (0, if i <> 0: .5 fi u)
				-- (.5u, 0) if i <> 0: dashed evenly fi
				withpen thickpen;
			draw origin -- (0, if i <> 0: .5 fi u)
				dashed evenly;
			if i <> 0:
			label.bot(TEX("$"&decimal(i)&"\omega_r$"), origin);
			fi
		) shifted (i * 1.5u, 0);
	endfor
	draw (-.75u,0)--(-.75u,u)--(.75u,u)--(.75u,0) dashed evenly;
	label.bot(btex$-\omega_c$etex, (-.75u,0));
	label.bot(btex$\omega_c$etex, (.75u,0));
endfig;

vardef dblarrowlabel(expr p, q, t) =
	save pic; picture pic;
	drawdblarrow p--q;
	pic := thelabel(t, .5[p,q]);
	unfill bbox.pic;
	draw pic;
enddef;

beginfig(27);
	resistor.Ra(origin);
	z1 = Ra.a shifted (-u, 0); z2 = Ra.b shifted (u, 0);
	z3 = z2 shifted (0, -2u);
	z4-z2=z2-Ra.b;
	z5-z1 = z3-z2 = z6-z4;
	capacitor.Ca(.5[z2,z3]);
	ground(z3 shifted (0, -.2u));
	draw z1--Ra.a;
	draw Ra.b--z4;
	draw z2--Ca.a;
	draw Ca.b--z3 shifted (0, -.2u);
	draw z3 withpen pencircle scaled 2.4pt;
	draw z5--z6;
	forsuffixes p = z1, z4, z5, z6:
		unfill fullcircle scaled 2pt shifted p;
		draw fullcircle scaled 2pt shifted p;
	endfor
	label.top("R" infont "cmmi10", Ra.c shifted (0, .1u));
	label.lft("C" infont "cmmi10", Ca.c shifted (-.1u, 0));
	dblarrowlabel(z1 shifted (0, -1pt),z5 shifted (0, 1pt))
		(btex$v_i(t)$etex);
	dblarrowlabel(z4 shifted (0, -1pt),z6 shifted (0, 1pt))(btex$v_o(t)$etex);
endfig;

beginfig(28);
	drawaxes((-3u, -1u), (3u, 1.5u))
		(btex$\omega$etex, btex$|H(j\omega)|$etex);
	save p; path p;
	p := (0, 1){right} for t := 1 upto 10:
		.. (.25t, 1/(1 ++ t/3))
	endfor;
	p := reverse(p xscaled -1)&p;
	draw p scaled u withpen thickpen;
	z1 = (.75, 1/sqrt2) scaled u;
	draw z1--(x1,0) dashed evenly;
	draw (-x1,y1)--(-x1,0) dashed evenly;
	label.bot(btex$\vphantom{-}\omega_c$etex, (x1,0));
	label.bot(btex$-\omega_c$etex, (-x1,0));
endfig;

beginfig(29);
	save w; w=0.2;
	save price; numeric price[]; % daily price
	save ma; numeric ma[];
	save period; numeric period[];
	save p; path p[];
	save today, wkday;
	save date; numeric date[];
	today := 1; wkday := 3; % starting from 11/1/2017
	period1 := 3; period2 := 5; period3 := 7;
	ma1:=0; ma2:=0; ma3:=0;
	% Open High Low Last
	draw begingraph(3in, 2in);
	gdata("aapl.d", v,
		for j = 1 upto 4:
			y[j] := scantokens v[j];
			x[j] := i;
		endfor
		price[i] := y4;
		gdraw z2--z4;
		gdraw z3--z1;
		if y1 <= y4: gdraw else: gfill fi
			z4 shifted (-w, 0) -- z4 shifted (w, 0)
			-- z1 shifted (w, 0) -- z1 shifted (-w, 0) -- cycle;
		for j = 1 upto 3:
			ma[j] := ma[j] + y4
				if i>period[j]: -price[i-period[j]] fi;
			if i >= period[j]:
				augment.p[j]((i,ma[j]/period[j]));
			fi
		endfor
		date[i] := today;
		if wkday=5:
			today := today + 3;
			wkday := 0;
		else:
			today := today + 1;
			wkday := wkday + 1;
		fi
	);
	gdraw p1;
	gdraw p2 dashed evenly;
	gdraw p3 dashed dashpattern(on 3 off 1.4 on .2 off 1.4);
	for i = 1,10,20:
		otick.bot("2017/11/"&decimal(date[i]), i);
	endfor
	autogrid(,otick.lft);
	endgraph;
endfig;

vardef groupfig(expr n) = 
	drawaxes((-2u, -u),(2u, 1.5u))
		(btex$\Omega$etex,
			TEX("$\bigl|H_{"&decimal(n)&
				"}\bigl(e^{j\Omega}\bigr)\bigr|$"));
	save p, q, horizon;
	path p, q, horizon;
	horizon := (origin -- (pi/2, 0)) xscaled u;
	p := (0, 1){right} for t = 1 upto 3n:
		.. (pi*t/(6n), sind(30t)/sind(30t/n)/n)
	endfor;
	save intersect, t;
	pair intersect; numeric t;
	save sign; sign := 1;
	forever:
		intersect := subpath(1, length p) of p
			intersectiontimes horizon;
		t := xpart intersect + 1;
		exitif t = 0;
		q := if known q: q& fi (subpath(0, t) of p yscaled sign);
		sign := -sign;
		p := subpath(t, length p) of p;
	endfor
	q := q & (p yscaled sign);
	draw (reverse(q xscaled -1)&q) scaled u withpen thickpen;

	label.bot(btex$\pi$etex, (pi*u/2, 0));
	label.bot(btex$-\pi$etex, (-pi*u/2, 0));
enddef;

beginfig(30); groupfig(3); endfig;
beginfig(31); groupfig(5); endfig;
beginfig(32); groupfig(7); endfig;

beginfig(33);
	drawaxes((-1.5u, 0), (6*u, 1.5u))
		("n" infont "cmmi10", btex$h_N[n]$etex);
	for i = 0,1,2,4:
		draw (i*u, 0)--(i*u, u);
		draw (i*u, u) withpen pencircle scaled dotlabeldiam;
	endfor
	for i = -1,5:
		draw (i*u, 0) withpen pencircle scaled dotlabeldiam;
	endfor
	for i = 0,1,2:
		label.bot(decimal(i), (i*u, 0));
	endfor
	label(btex$\cdots$etex, (3u, .5u));
	label.bot(btex$\cdots$etex, (3u, 0));
	label.bot(btex$N-1$etex, (4u, 0));
	label.lft(btex$1\over N$etex, (0, u));
endfig;

beginfig(34);
	drawaxes((-3u, -u),(3u, 1.5u))
		("t" infont "cmmi10", btex$\delta_T(t)$etex);
	save q; pair q;
	interim ahlength := 3pt;
	for i = 0 upto length sincsquarewave:
		q := point i of sincsquarewave;
		drawarrow ((xpart q, 0)--(xpart q, 1)) scaled u;
	endfor
	label.bot("T" infont "cmmi7",
		(xpart point length sincsquarewave / 2 + 1
			of sincsquarewave, 0) scaled u);
endfig;

beginfig(35);
	drawaxes((-3u, -u),(3u, 1.5u))
		("t" infont "cmmi10", btex$x_T(t)$etex);
	save q; pair q;
	interim ahlength := 3pt;
	for i = 0 upto length sincsquarewave:
		q := point i of sincsquarewave;
		drawarrow ((xpart q, 0)--q) scaled u;
	endfor
	%draw sincsquarewave scaled u dashed evenly;
endfig;

beginfig(36);
	drawaxes((-3u, -u),(3u, 1.5u))
		(btex$\omega$etex, btex$\Delta_T(j\omega)$etex);
	interim ahlength := 3pt;
	for i = -2 upto 2:
		drawarrow ((i,0)--(i,1)) scaled u;
	endfor
	label.bot(btex$\omega_s$etex, (u, 0));
	label.lft(btex$2\pi\over T$etex, (0, u));
endfig;

beginfig(37);
	drawaxes((-3u, -u),(3u, 1.5u))
		(btex$\omega$etex, btex$X_T(j\omega)$etex);
	for i = -2 upto 2:
		draw ((-.5,0)--(0,.5)--(.5,0)) shifted (i, 0) scaled u
			withpen thickpen;
		draw ((i,0)--(i,.5)) scaled u dashed evenly;
	endfor
	label.bot(btex$\omega_s$etex, (u, 0));
endfig;

beginfig(38);
	drawaxes((-3u, -u),(3u, 1.5u))
		("n" infont "cmmi10", btex$x[n]$etex);
	save q; pair q;
	for i = 0 upto length sincsquarewave:
		q := point i of sincsquarewave;
		draw ((xpart q, 0)--q) scaled u;
		draw q scaled u withpen pencircle scaled 2pt;
	endfor
	%draw sincsquarewave scaled u dashed evenly;
endfig;

beginfig(39);
	drawaxes((-3u, -u),(3u, 1.5u))
		(btex$\Omega$etex, btex$X\bigl(e^{j\Omega}\bigr)$etex);
	for i = -2 upto 2:
		draw ((-.5,0)--(0,.5)--(.5,0)) shifted (i, 0) scaled u
			withpen thickpen;
		draw ((i,0)--(i,.5)) scaled u dashed evenly;
	endfor
	label.bot(btex$2\pi$etex, (u, 0));
endfig;

beginfig(40);
	drawaxes((-3u, -u),(3u, 1.5u))
		("t" infont "cmmi10", btex$x(t)$etex);
	save p; path p[];
	for n = 1, 3:
		p[n] := for i = -n upto n: if i <> -n: & fi
			(cosinewave shifted (2i, 0))
		endfor;
	endfor;
	draw p3 xscaled (u/3) yscaled u;
	draw subpath (6, 30) of p1 scaled u
		dashed evenly withpen thickpen;
	for i = 6 step 9 until length p3:
		draw point i of p3 xscaled (u/3) yscaled u
			withpen pencircle scaled dotlabeldiam;
	endfor;
	label.rt(btex$\cos3t$etex, (2.333u, -u));
	label.rt(btex$\cos t$etex, (2u, u));
endfig;

beginfig(41);
	drawaxes((-3.5u, -u),(3.5u, 2u))
		(btex$\omega$etex, btex$X_T(j\omega)$etex);
	drawarrow ((-3,0)--(-3,1)) scaled u;
	drawarrow ((-1,0)--(-1,1)) scaled u dashed evenly withcolor .5white;
	drawarrow ((1,0)--(1,1)) scaled u dashed evenly;
	drawarrow ((3,0)--(3,1)) scaled u withcolor .5white;
	for i=-3 upto 3: if i <> 0:
		label.bot(TEX("$"&decimal(i)&"$"), (i*u, 0));
	fi endfor;
	draw ((-2,0)--(-2,1.5)--(2,1.5)--(2,0)) scaled u dashed evenly;
endfig;

beginfig(42);
	drawaxes((-1.5u, -1.5u),(1.5u, 1.5u)) xylabels;
	draw fullcircle scaled 2u withpen thickpen;
	draw origin -- dir 60 scaled u;
	drawarrow (dir60..dir70..dir80) scaled 1.1u;
	label.top(btex$\scriptstyle\omega$etex, dir60 scaled 1.1u);
	dotlabel.bot("P" infont "cmmi10", dir 60 scaled u);
	%for i=0 step 15 until 345:
	%	draw origin -- dir i scaled u dashed evenly;
	%endfor;
endfig;

beginfig(43);
	drawaxes((-3u, -u),(3u, 2u))
		(btex$\omega$etex, btex$Z_T(j\omega)$etex);
	drawarrow ((1,0)--(1,1)) scaled u;
	label.bot(btex$\omega_0$etex, (1u,0));
	for i=-2,-1,1:
		drawarrow ((1,0)--(1,1)) shifted (1.5i, 0) scaled u
			dashed evenly;
	endfor
	draw (1.5u,0)--(1.5u,.1u);
	label.bot(btex$\omega_s$etex, (1.5u,0));
	draw ((-.75,0)--(-.75,1.5)--(.75,1.5)--(.75,0)) scaled u
		dashed evenly;
endfig;

def groupfig(expr t)=
	draw fullcircle scaled u;
	draw origin -- dir t scaled .5u withpen thickpen;
	draw dir t scaled .5u withpen pencircle scaled 2pt;
enddef;

beginfig(44);
	for i = 0 upto 8:
		draw image(groupfig(135*i)) shifted (1.5u*i, 0);
	endfor
	for i = 0 step 2 until 8:
		draw image(groupfig(135*i)) shifted (1.5u*i, -1.5u);
	endfor
	label.lft(btex$\omega_s={8\over3}\omega_0$etex, (-.75u, 0));
	label.lft(btex$\omega_s={4\over3}\omega_0$etex, (-.75u,-1.5u));
endfig;

picture MPbullet;
MPbullet = image ( draw origin withpen pencircle scaled 3pt );

beginfig(45);
	draw begingraph(3in, 1in)
		gdata("dft.d", v,
			gdraw (i-1, 0)--(i-1, scantokens v1);
			gdraw (i-1, scantokens v1) plot MPbullet;
		);
	endgraph;
endfig;

beginfig(46);
	draw begingraph(3in, 1in)
		gdata("dft.d", v,
			gdraw (i-1, 0)--(i-1, scantokens v1);
			gdraw (i-1, scantokens v1) plot MPbullet;
		);
	endgraph;
endfig;
%end
