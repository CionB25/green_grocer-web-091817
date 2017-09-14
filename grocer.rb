def consolidate_cart(cart)
  # code here
  new_cart_who_dis = {}

  cart.each do |food|
    food.each do |item, attribute|
      if !new_cart_who_dis.has_key?(item)
        new_cart_who_dis[item] = attribute
        new_cart_who_dis[item][:count] = 1
      else
        new_cart_who_dis[item][:count] += 1
      end
    end
  end
  new_cart_who_dis
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |coupon|
    name = coupon[:item]
    if cart[name] && cart[name][:count] >= coupon[:num]
      if (cart["#{name} W/COUPON"])
        cart["#{name} W/COUPON"][:count] += 1
      else
        cart["#{name} W/COUPON"] = {price: coupon[:cost], clearance: cart[name][:clearance], count: 1}
      end
      cart[name][:count] -= coupon[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  # code here
  cart.each do |item, info|
    if info[:clearance] == true
      info[:price] = (info[:price]*0.8).round(2)
    end
  end
end

def checkout(cart, coupons)
  # code here
  total = 0.00

  cart = consolidate_cart(cart)
  coupCart = apply_coupons(cart, coupons)
  allCart = apply_clearance(coupCart)

  allCart.each do |item, info|
      total += (info[:price] * info[:count])
  end

  if total > 100
      total *= 0.9
  end

  total

end
