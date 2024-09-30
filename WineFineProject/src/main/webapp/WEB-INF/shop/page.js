	const page_card = {
			  template: `<ul class="pagination">
			    <li v-if="$parent.startpage > 1"><a class="nav-link" @click="$parent.prev()">&lt;</a></li>
			    <li v-for="i in $parent.range($parent.startpage, $parent.endpage)" 
			        :class="i === $parent.curpage ? 'active' : ''">
			      <a class="nav-link" @click="$parent.pagechange(i)">{{ i }}</a></li>
			    <li v-if="$parent.endpage < $parent.totalpage"><a class="nav-link" @click="$parent.next()">&gt;</a></li>
			  </ul>`
			}