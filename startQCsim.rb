#Simple quantum computer/gate simulator written in Ruby by Leif-Erik Hallmann, 2021.
#
#Read readme.txt for commands to write in .qc file and info about the quantum gates.

require 'matrix.rb'



#______________________Qubit Initializer________________________

def ini_qbits(n)
	@qbit = Array.new(n, Matrix.column_vector( [1.0, 0.0] ))
	@entanglements = {}
end

#____________________Entanglement Checker_________________

def entanglement_check(e)
	if @entanglements.include?(:"@qbit[#{e}]") then
		value=@entanglements[:"@qbit[#{e}]"].scan(/\d/).join.to_i
	elsif @entanglements.invert.include?("@qbit[#{e}]") then
		value=@entanglements.key("@qbit[#{e}]").to_s.scan(/\d/).join.to_i
	elsif @entanglements.invert.include?("-@qbit[#{e}]") then
		value=@entanglements.key("-@qbit[#{e}]").to_s.scan(/\d/).join.to_i
	else
		value=false
	end	
	return value 
end

#______________________Single Qubit Gates_______________________

def i(q)
  	identity = Matrix.identity(2)
  	@qbit[q] = identity * @qbit[q]
	if entanglement_check(q) != false then
		@qbit[entanglement_check(q)] = identity * @qbit[entanglement_check(q)]
	end
end

def x(q)
  	paulix = Matrix[ [0, 1], [1, 0] ]
  	@qbit[q] = paulix * @qbit[q]
	if entanglement_check(q) != false then
		@qbit[entanglement_check(q)] = paulix * @qbit[entanglement_check(q)]
	end
end

def y(q)
	pauliy = Matrix[ [0, Complex(0, -1)], [Complex(0, 1), 0] ]
	@qbit[q] = pauliy * @qbit[q]
	if entanglement_check(q) != false then
		@qbit[entanglement_check(q)] = pauliy * @qbit[entanglement_check(q)]
	end
end

def z(q)
  	pauliz = Matrix[ [1, 0], [0, -1] ]
  	@qbit[q] = pauliz * @qbit[q]
	if entanglement_check(q) != false then
		@qbit[entanglement_check(q)] = pauliz * @qbit[entanglement_check(q)]
	end
end

def h(q)
  	hadamard = Matrix[ [1, 1], [1, -1] ] / (Math.sqrt(2))
  	@qbit[q] = hadamard * @qbit[q]
	if entanglement_check(q) != false then
		@qbit[entanglement_check(q)] = hadamard * @qbit[entanglement_check(q)]
	end
end

def s(q)
	phase = Matrix[ [1, 0], [0, Complex(0, 1)] ]
	@qbit[q] = phase * @qbit[q]
	if entanglement_check(q) != false then
		@qbit[entanglement_check(q)] = phase * @qbit[entanglement_check(q)]
	end
end

def sd(q)
	phasedagger = Matrix[ [1, 0], [0, Complex(0, -1)] ]
	@qbit[q] = phasedagger * @qbit[q]
	if entanglement_check(q) != false then
		@qbit[entanglement_check(q)] = phasedagger * @qbit[entanglement_check(q)]
	end
end

def t(q)
	phaset = Matrix[ [1, 0], [0, (Math::E.to_c ** (Complex(0,1) * Math::PI.to_c / 4))] ]
	@qbit[q] = phaset * @qbit[q]
	if entanglement_check(q) != false then
		@qbit[entanglement_check(q)] = phaset * @qbit[entanglement_check(q)]
	end
end

def td(q)
	phasetdagger = Matrix[ [1, 0], [0, (Math::E.to_c ** (Complex(0, -1) * Math::PI.to_c / 4))] ]
	@qbit[q] = phasetdagger * @qbit[q]
	if entanglement_check(q) != false then
		@qbit[entanglement_check(q)] = phasetdagger * @qbit[entanglement_check(q)]
	end
end

def v(q)
	vgate = Matrix[ [Complex(1, 1),Complex(1, -1)],[Complex(1, -1), Complex(1, 1)] ] / 2
	@qbit[q] = vgate * @qbit[q]
	if entanglement_check(q) != false then
		@qbit[entanglement_check(q)] = vgate * @qbit[entanglement_check(q)]
	end
end

def vd(q)
	vgated = Matrix[ [Complex(1, -1),Complex(1, 1)],[Complex(1, 1), Complex(1, -1)] ] / 2
	@qbit[q] = vgated * @qbit[q]
	if entanglement_check(q) != false then
		@qbit[entanglement_check(q)] = vgated * @qbit[entanglement_check(q)]
	end
end

def rx(theta, q)
	rotx = Matrix[ [Math.cos(theta / 2).to_c, Complex(0,-(Math.sin(theta / 2)))],[Complex(0,-(Math.sin(theta / 2))), Math.cos(theta / 2).to_c] ]
	@qbit[q] = rotx * @qbit[q]
	if entanglement_check(q) != false then
		@qbit[entanglement_check(q)] = rotx * @qbit[entanglement_check(q)]
	end
end

def ry(theta, q)
	roty = Matrix[ [Math.cos(theta / 2), -(Math.sin(theta / 2))],[(Math.sin(theta / 2)), Math.cos(theta / 2)] ]
	@qbit[q] = roty * @qbit[q] 
	if entanglement_check(q) != false then
		@qbit[entanglement_check(q)] = roty * @qbit[entanglement_check(q)]
	end
end

def rz(theta, q)
	rotz = Matrix[ [Math::E.to_c ** (Complex(0,-(theta / 2))), 0],[0, Math::E.to_c ** (Complex(0, theta / 2))] ]
	@qbit[q] = rotz * @qbit[q]
	if entanglement_check(q) != false then
		@qbit[entanglement_check(q)] = rotz * @qbit[entanglement_check(q)]
	end
end


#______________________Multi Qubit Gates________________________

def cx(c, q)
	cnot = Matrix[ [1.0, 0.0, 0.0, 0.0], [0.0, 1.0, 0.0, 0.0], [0.0, 0.0, 0.0, 1.0], [0.0, 0.0, 1.0, 0.0] ]

	tensorprodukt = Matrix.column_vector( [0.0, 0.0, 0.0, 0.0] )
	@qbit[c].each_with_index do |vc, ic|
		@qbit[q].each_with_index do |vq, iq|
			tensorprodukt[(ic.to_s + iq.to_s).to_i(2), 0] = vc * vq
		end
	end
	tensorprodukt = cnot * tensorprodukt
	
	q0 = "empty"
	q1 = "empty"
	
	if @qbit[c][0, 0] != 0 then
		q0 = tensorprodukt[0, 0]/@qbit[c][0, 0]
		q1 = tensorprodukt[1, 0]/@qbit[c][0, 0]
		@qbit[q] = Matrix.column_vector( [q0, q1] )
	end
	if @qbit[c][1, 0] != 0 then
		if (tensorprodukt[2, 0]/@qbit[c][1, 0] != q0 or tensorprodukt[3, 0]/@qbit[c][1, 0] != q1) && q0 != "empty" && tensorprodukt[0, 0] ** 2 > tensorprodukt[2, 0] ** 2 then
			@entanglements[:"@qbit[#{q}]"] = "@qbit[#{c}]"
			@qbit[q] = @qbit[c]
		elsif (tensorprodukt[2, 0]/@qbit[c][1, 0] != q0 or tensorprodukt[3, 0]/@qbit[c][1, 0] != q1) && q0 != "empty" && tensorprodukt[1, 0] ** 2 > tensorprodukt[3, 0] ** 2 then
			@entanglements[:"@qbit[#{q}]"] = "-@qbit[#{c}]"
			@qbit[q] = @qbit[c]
			x(q)
		else
			q0 = tensorprodukt[2, 0]/@qbit[c][1, 0]
			q1 = tensorprodukt[3, 0]/@qbit[c][1, 0]
			@qbit[q] = Matrix.column_vector( [q0.abs(), q1] )
		end
	end
end

def cy(c, q)
	sd(q)
	cx(c,q)
	s(q)
end

def cz(c, q)
	h(q)
	cx(c,q)
	h(q)
end

def ch(c, q)
	ry((Math::PI / 4), q)
	cx(c, q)
	ry(-(Math::PI / 4), q)
end

def swp(q0, q1)
	swap = Matrix[ [0,0,1,0],[0,0,0,1],[1,0,0,0],[0,1,0,0] ]
	combined = swap * Matrix.vstack(@qbit[q0],@qbit[q1])
	@qbit[q0] = Matrix.vstack(combined.row(0),combined.row(1))
	@qbit[q1] = Matrix.vstack(combined.row(2),combined.row(3))
end

def ccx(c0, c1, q)
	ch(c0, q)
	cz(c1, q)
	ch(c0, q)
end


#_____________________Measurement Function______________________

results = {}

def random_weighted(weighted)
	max    = sum_of_weights(weighted)
	target = rand(0..max)
	weighted.each do |item, weight|
		return item if target <= weight
		target -= weight
	end
end

def sum_of_weights(weighted)
	weighted.inject(0) { |sum, (item, weight)| sum + weight }
end


#________________________User Interface__________________________

puts("Quantum circuit simulator by Leif-Erik Hallmann, 2021.")
puts()

#INPUT
puts("Which Quantum-Code file should be loaded?")
filename = gets().chop

#RUN
load filename

puts(@entanglements)

#OUTPUT
puts()
for i in 0..@qbit.size-1 do
	puts("Qubit" + i.to_s + "_____________________________________________")
	puts()
	if @entanglements.invert.include?("@qbit[#{i}]") == true
		puts("!!! Qubit" + i.to_s + " is entangled to Qubit" + @entanglements.key("@qbit[#{i}]").to_s.scan(/\d/).join + " !!!")
		puts()
		puts("Vector: ")
		puts(@qbit[i] [0, 0].real.round(2).to_s + " + " + @qbit[i][0, 0].imaginary.round(2).to_s + "i")
		puts(@qbit[i] [1, 0].real.round(2).to_s + " + " + @qbit[i][1, 0].imaginary.round(2).to_s + "i")
		puts()
		p0 = (@qbit[i][0,0].real ** 2).round(2) + (@qbit[i][0, 0].imaginary ** 2).round(2)
		p1 = (@qbit[i][1,0].real ** 2).round(2) + (@qbit[i][1, 0].imaginary ** 2).round(2)
		puts("p0: " + p0.to_s)
		puts("p1: " + p1.to_s)
		if results.include?(:"#{@entanglements.key("@qbit[#{i}]").to_s.scan(/\d/).join.to_i}") then
			puts("Measurement: " + results[:"#{@entanglements.key("@qbit[#{i}]").to_s.scan(/\d/).join.to_i}"].to_s)
		else
			results[:"#{i}"] = random_weighted("0": p0, "1": p1)
			puts("Measurement: " + results[:"#{i}"].to_s)
		end

	elsif @entanglements.invert.include?("-@qbit[#{i}]") == true
		puts("!!! Qubit" + i.to_s + " is entangled to Qubit" + @entanglements.key("-@qbit[#{i}]").to_s.scan(/\d/).join + " !!!")
		puts()
		puts("Vector: ")
		puts(@qbit[i] [0, 0].real.round(2).to_s + " + " + @qbit[i][0, 0].imaginary.round(2).to_s + "i")
		puts(@qbit[i] [1, 0].real.round(2).to_s + " + " + @qbit[i][1, 0].imaginary.round(2).to_s + "i")
		puts()
		p0 = (@qbit[i][0,0].real ** 2).round(2) + (@qbit[i][0, 0].imaginary ** 2).round(2)
		p1 = (@qbit[i][1,0].real ** 2).round(2) + (@qbit[i][1, 0].imaginary ** 2).round(2)
		puts("p0: " + p0.to_s)
		puts("p1: " + p1.to_s)
		if results.include?(:"#{@entanglements.key("-@qbit[#{i}]").to_s.scan(/\d/).join.to_i}") then
			if results[:"#{@entanglements.key("-@qbit[#{i}]").to_s.scan(/\d/).join.to_i}"].to_s == "0" then
				puts("Measurement: " + "1")
			else 
				puts("Measurement: " + "0")
			end
		else
			results[:"#{i}"] = random_weighted("0": p0, "1": p1)
			if results[:"#{i}"].to_s == "0"
				puts("Measurement: " + "1")
			else
				puts("Measurement: " + "0")
			end
		end

	elsif	@entanglements.include?(:"@qbit[#{i}]") == true
		puts("!!! Qubit" + i.to_s + " is entangled to Qubit" + @entanglements[:"@qbit[#{i}]"].scan(/\d/).join + " !!!")
		puts()
		puts("Vector: ")
		puts(@qbit[i] [0, 0].real.round(2).to_s + " + " + @qbit[i][0, 0].imaginary.round(2).to_s + "i")
		puts(@qbit[i] [1, 0].real.round(2).to_s + " + " + @qbit[i][1, 0].imaginary.round(2).to_s + "i")
		puts()
		p0 = (@qbit[i][0,0].real ** 2).round(2) + (@qbit[i][0, 0].imaginary ** 2).round(2)
		p1 = (@qbit[i][1,0].real ** 2).round(2) + (@qbit[i][1, 0].imaginary ** 2).round(2)
		puts("p0: " + p0.to_s)
		puts("p1: " + p1.to_s)
		if results.include?(:"#{@entanglements[:"@qbit[#{i}]"].scan(/\d/).join.to_i}") then
			puts("Measurement: " + results[:"#{@entanglements[:"@qbit[#{i}]"].scan(/\d/).join.to_i}"].to_s)
		else
			results[:"#{i}"] = random_weighted("0": p0, "1": p1)
			puts("Measurement: " + results[:"#{i}"].to_s)
		end
			
	else
		puts("Vector: ")
		puts(@qbit[i][0, 0].real.round(2).to_s + " + " + @qbit[i][0, 0].imaginary.round(2).to_s + "i")
		puts(@qbit[i][1, 0].real.round(2).to_s + " + " + @qbit[i][1, 0].imaginary.round(2).to_s + "i")
		puts()
		p0 = (@qbit[i][0,0].real ** 2).round(2) + (@qbit[i][0, 0].imaginary ** 2).round(2)
		p1 = (@qbit[i][1,0].real ** 2).round(2) + (@qbit[i][1, 0].imaginary ** 2).round(2)
		puts("p0: " + p0.to_s)
		puts("p1: " + p1.to_s)
		results[:"#{i}"] = random_weighted("0": p0, "1": p1)
		puts("Measurement: " + results[:"#{i}"].to_s)
	end
	puts()
end
