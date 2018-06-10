elseif text:match('^(set answer) "(.*)" (.*)') then
					local txt, answer = text:match('^set answer "(.*)" (.*)')
					redis:hset("botBOT-IDanswers", txt, answer)
					redis:sadd("botBOT-IDanswerslist", txt)
					return send(msg.chat_id_, msg.id_, "<i>answer for | </i>" .. tostring(txt) .. "<i> | set for this :</i>\n" .. tostring(answer))
				elseif text:match("^(delete answer) (.*)") then
					local matches = text:match("^delete answer (.*)")
					redis:hdel("botBOT-IDanswers", matches)
					redis:srem("botBOT-IDanswerslist", matches)
					return send(msg.chat_id_, msg.id_, "<i>answer for | </i>" .. tostring(matches) .. "<i> | deleted from auto answer list.</i>")
				elseif text:match("^(auto answer) (.*)$") then
					local matches = text:match("^auto answer (.*)$")
					if matches == "on" then
						redis:set("botBOT-IDautoanswer", true)
						return send(msg.chat_id_, 0, "<i>auto answer is on</i>")
					elseif matches == "off" then
						redis:del("botBOT-IDautoanswer")
						return send(msg.chat_id_, 0, "<i>auto answer is off.</i>")
end		
